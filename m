Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3379C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:24:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83723875F5;
	Mon,  4 Dec 2023 01:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="OELGIaOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9C1875DF; Sun,  3 Dec 2023 18:27:50 +0100 (CET)
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0EB8759C
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ubroot37@proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=vu5pnrxudfbithdk4myvupp3je.protonmail; t=1701624467; x=1701883667;
 bh=fQx4DgIO8WRjPcizlZH505d+10TgtJA35QkJoNI99r0=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=OELGIaOK3ddENsQX3P353TJ/o13OZm8koDS682b8SRg2Gr6Ww4FParbjpOADDzSVA
 Kky1HSqTDTKygQxuwAkO0MsF2cs4Vr30dnIFio6/tl/i07n2ruCxAudaDYtslrCbiJ
 yanZAmPjmkPE3dFWhyam2FktgPfFjH8UOT2cnEe0xAG3DT1FvR2+raLHK4kkG8L7Fy
 ZuzECRYJcD58daqYfXYJ1TUKXTm3f+xK5qgqw0rp3rLieQ61ePHOyjAYPH6XIremur
 OQjXMY7gzwmSwQ5Galfk38pvnF430mElgjumSt6G/o/0WxKIqlvYAKX+fRGzhxRQT3
 A21Swwdj3mGRQ==
Date: Sun, 03 Dec 2023 17:27:31 +0000
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: ubroot37 <ubroot37@proton.me>
Subject: rk3328 gmac does U-Boot erroneously not set RSF?
Message-ID: <b1aNNi5jB7PW_exaGts62-LnkNoYW9xrdFW0SxIPsrStzzzC6TFAIEeCUpGDhrLKUBGHRnAkrF01qXQegDTHN7LsFr6IDmmWpBbA8GGfT8M=@proton.me>
Feedback-ID: 94133723:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 04 Dec 2023 01:24:45 +0100
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

Hi all,

I suspect U-Boot is not setting the RSF bit in GMAC_OP_MODE register. This =
can result in allowing to receive frames with bad CRC. I suspect the Linux =
driver may be similarly affected, but I have not checked it out.

Unfortunately all my spare time is taken up by development on my own OS, so=
 I do not have the time to investigate fully and/or provide a patch. I am j=
ust reporting this potential issue as a good Samaritan, but please understa=
nd that I am not willing to apply any patches or recompile U-Boot or conduc=
t any tests or anything of that nature.

Thanks all.

