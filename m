Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096C6C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B48820E1;
	Mon,  5 May 2025 15:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746451600;
	bh=t4PpD3IfOtup98I5ANzDZnRtBvbpkQGcLjqAarV4Ohs=;
	h=Date:To:Cc:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=yyBN7PBPHkSY1UvSeaSk3BK6vImPDeOhiESQ0DhjpN3Ryz/KsaZyd2YbXxmRLNNUe
	 w0IcXiJJaH/VFAVRnhYvRuSjcHhmOX35c+tvMGUflH9Kt7P5bHi1NzlaVa5FGvGcgR
	 rja8gmwMzbuBZ8Abb0lm0A2qrfEak/ziA3gdt6mEsaQBgPBDh4pgl2GBzarGF2KZL4
	 XZbnSlTbXiQ0SJ5rY/Rnl8Yhy/MfY+q5NreS7TbJd8CfjXTdT6sy70d/veTe2+OzY7
	 PDnvTN54vNrE+DBTVzH7XP9jRk87OtGamUEJ1gTkLzMDggSbybgqorJxyo5ExBEUhi
	 U/v8DuYwWGEQA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6896282935; Mon,  5 May 2025 15:26:39 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DEC082076
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MzMSCh/G"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 783D11048C2EF; 
 Mon,  5 May 2025 15:26:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746451596;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=t4PpD3IfOtup98I5ANzDZnRtBvbpkQGcLjqAarV4Ohs=;
 b=MzMSCh/GqYZxMI2sYgLZxa0D7stAMnuru3OKd25NXUVKoH/8SfJmJySP2oRMV3EBun2UJp
 S/Z/7J687t8lKEwlNv3mgaSbPx0cYvjcKdsSDiCGrJl3jwyqX6iHD+nkZaTSF6uQsFV/t5
 4KCIvvRihCrzoMsyJ+BoLrQ2XBOA79g8yEZ8QH0crqhL6DjRWhieUK/oSKz1/H7IU1UxYw
 ESBv9mYHJapwQFjQLX1Lj4vY5YkumYHVkmjCKl8EdufdHO0GvjZ0sClwc32E6QguVgWZHq
 29sXpWkq0r40pQwUsu7uqMYvFl6dndm5qvtsCV/TjsHveIL/iXjhoUs91BKfIg==
Message-ID: <c7632b5b-7fe5-3ded-e42d-5554edc533e9@denx.de>
Date: Mon, 5 May 2025 15:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alexander Vickberg <wickbergster@gmail.com>
From: Heiko Schocher <hs@denx.de>
Subject: Please pull u-boot-ubi master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

please pull from u-boot-ubi master

The following changes since commit 9dbe8d889546efd6c1a3470092588b9b6820158f:

   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-05-04 13:44:01 
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubifixes-for-2025.07-rc2

for you to fetch changes up to c81d8efb51480b318f0bd0a3bdf2d5b0445bbbc9:

   mtd: ubi: Put MTD device after it is not used (2025-05-05 10:15:43 +0200)

----------------------------------------------------------------
ubi fixes for v2025.07-rc2

- fix bug: Put MTD device after it is not used
   drop MTD device reference after it is not longer used!
   port from upstream Linux commit: b95f83ab762dd6211351b9140f99f43644076ca8
   from Alexander Vickberg

----------------------------------------------------------------
Alexander Vickberg (1):
       mtd: ubi: Put MTD device after it is not used

  drivers/mtd/ubi/build.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)


Azure run is fine:
https://dev.azure.com/hs0298/hs/_build/results?buildId=176&view=results

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
