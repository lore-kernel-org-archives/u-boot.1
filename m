Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0262E909A3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 13:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A1B8063E;
	Tue, 17 Feb 2026 14:40:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="d9g2tLqm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rj+MY6j2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F6483C61; Tue, 17 Feb 2026 11:46:09 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF1680325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=aleksandr.iashchenko@linutronix.de
Message-ID: <9323f110-ad2a-4982-82a3-bf13bcfeb6c6@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1771325165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EA2moJghFrAw9C+I1m227QDnZoA/BYMk6W8a8hh5ijo=;
 b=d9g2tLqmUYBY+ezXEX1NBenKmzMw2TXR5RyODRChV/sm4CFpXtEupW5gGizMdL5qIz3bS6
 3vSVrL0/N5riNW9P7rGGxefMJdX9UqPso/EOWeziOxQ3vLORc0TnpnZft+FXU3eyYFP46J
 O5Glhv+7rJLCs/mhViqfaFFRMFH3yJfR2Y60hXWfySB6cEZV6F0L3a6/ClWwsKJIbiknKc
 NyxImYU7Bxe5SjOeP4724wApmFumNyvzxJDL/uilyLhFVHmAbsxPacksDUpIGmutZskmia
 rlxxR9V4VFTBE8TtcReP5bEwrIrRC34jrpbSdLlr3S3Ag+izxMIUKZi9jUco5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1771325165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EA2moJghFrAw9C+I1m227QDnZoA/BYMk6W8a8hh5ijo=;
 b=rj+MY6j2DxVj9SZA01y7bIFFR8UOF7sC+Pteiyy84HFybOmDaWcRR08IOhytAb4R7MQ8lm
 vG7JlKBSJ7ltXMBQ==
Date: Tue, 17 Feb 2026 11:46:04 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Aleksandr Iashchenko <aleksandr.iashchenko@linutronix.de>
To: u-boot@lists.denx.de
Cc: akashi.tkhro@gmail.com, kojima.masahisa@socionext.com
Subject: [RFC] efi_loader: UKI Secure Boot verification failure with PE
 section gaps
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 17 Feb 2026 14:40:19 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

I am using U-Boot as UEFI firmware and trying to boot a Unified Kernel Image 
(UKI) with Secure Boot enabled.

I see a signature verification failure in U-Boot, even though the image is 
signed with the correct key (trusted in db).
The issue appears to be related to gaps between PE sections (UKI built by ukify 
from systemd).

My understanding of the current flow / why signature verification fails: 


1. efi_image_parse() computes bytes_hashed as a sum of aligned section sizes 
(without explicitly accounting for file gaps). This seems consistent with what 
sbsign is doing.
2. Then the final "extra data" region is defined as the range from efi + 
bytes_hashed up to the certificate table. This region will have non-zero length 
in case if there were gaps.
3. The start of "extra data" region will overlap with already added regions.
4. As a result, efi_image_region_add(..., nocheck=0) will reject this final 
region because of the detected overlap, so it is not included in the hashed 
region list. In contrast, sbsigntools still computes the hash including this 
final extra-data range, which leads to a mismatch and signature verification 
failure in U-Boot.

I'm not entirely sure - is this an issue on the U-Boot side? I reviewed the 
Authenticode specification (the PE/COFF hashing rules), but I did not find a 
clear description of how gaps between sections should be handled when computing 
the hashed regions. In practice, the way U-Boot computes the hash in this case 
it seems differs from how sbsigntools computes it. Would it make sense to 
include the final "extra data" region regardless of a potential overlap (i.e., 
using nocheck=1) so that verification remains consistent with the signing tools?

Thanks for your feedback.
