Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E7AD358F6
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0077B83D1A;
	Thu, 29 Jan 2026 11:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="tsOyr3Z3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A8B83B64; Thu, 29 Jan 2026 10:40:41 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77F7283E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=olivier.benjamin@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1D27F1A2AE9
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:40:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E3093606B6
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:40:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 66964119A884E
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:40:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769679632; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding; bh=CYZVsOeunpGKn0soIBFfBdodtRBm9xkiLb37a7z14y4=;
 b=tsOyr3Z3ooyR2MfZrbi3ursyZIytcVZDpQiPIa2GWrcCX+n1EwzPGBcNW0pYp2l7cOmyFB
 LcJRLfs+CIW6Cxib8dFAMPpY489hWDGf2aRFgTOcOhfkXRw+oOcqSjeJZVJE6c4wlqEd7E
 7V8o287PPakCew7JYoEoXF8nI86LcUrVjDtUOhUQZsbvEq0Nd56fuCCNqXQ3kemzYjkNAQ
 eaxm8EKpAsvpWqdRDQXSN4wtpd9XncAKTHzzF1mTFaMhfo/mBioHEzbevmoP9fhpuEk9qp
 /T2IR3+FVzmlaypNPKaS26+FoPcmBAMmvYPqK7yb0fMvXg52Ru1GrwSFZH6QpA==
Date: Thu, 29 Jan 2026 10:40:31 +0100
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
To: "=?utf-8?Q?u-boot=40lists.denx.de?=" <u-boot@lists.denx.de>
Message-ID: <553E6DA2-7E8D-447D-BBD4-B7F0DA8B359C@getmailspring.com>
Subject: [RFC] Kernel command line from FIT image
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 29 Jan 2026 11:53:26 +0100
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

Hello,

While reading section 5.7.3 of the FIT image spec [1], I noticed the
"cmdline" property:

"cmdline
Command line passed to the next boot stage, e.g. the operating system
kernel. The value is an UTF-8 encoded string." 

However, looking at the mkimage sources, more specifically
include/image.h [2], it looks like this property is unsupported.

If properly implemented so that the cmdline can be signed, this would
imho be a viable option for passing the dm-verity bootargs in verified boot.
It could be an alternative to the option of sourcing a script that has
to be referenced via the configuration, as discussed in [3].

I have not found a discussion regarding supporting this property in
U-Boot, has it been discussed and rejected, or has it not made it to
contributor's priority list?

Kind regards,

Olivier

[1]: https://fitspec.osfw.foundation/#optional-properties
[2]: https://elixir.bootlin.com/u-boot/v2026.01/source/include/image.h#L1095
 [3]:
https://source.denx.de/u-boot/u-boot/-/commit/bcc85b96b5ffbbce19a89747138feb873d918915
