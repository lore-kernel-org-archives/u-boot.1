Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA0C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 05:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEF787D33;
	Tue,  5 Mar 2024 06:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="QfYhU4Yz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED4987DD5; Tue,  5 Mar 2024 06:45:20 +0100 (CET)
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com
 [203.205.221.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D83879F6
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 06:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1709617510; bh=Q6YEyGPuh3e4r9Nh61DUXhVlrxjigSE7cRDlT7QKeUM=;
 h=From:Subject:Date:Cc:To;
 b=QfYhU4YzwdhgPnvRtZ1NfKrjUehXdZehNf3YrN0DGo85p1UuAqY5p4/j6W7gOAw1C
 LkwuP7vRReTBSEu5r8Isvvr2UCLuZkMNxMQ57jxhfDXZpFEeos9Lk5T+lWaGZ8sEFH
 g2TnL+w7hcq7CaKHsFpGcJkUV0EFPSMntDW4vPmo=
Received: from smtpclient.apple ([183.173.155.235])
 by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
 id B47B8A1C; Tue, 05 Mar 2024 13:45:07 +0800
X-QQ-mid: xmsmtpt1709617507teun5ehjr
Message-ID: <tencent_BC8E058072E3862F034BBECDA7FFFD923F07@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH34aL6pfpCOaWndWfxKbvcKMwqxttkbUcJuEy1qJtkiiHP0BlTKv
 kLuX5Cojg+tWERDxAMCPiLXqjNrPPf6WUfantg3cGoS/eg2wwZC/xpwnORhC0Yncg7iqgu5Wl8Vz
 S3JDkmM/5MSak4HFfDQZuz6VgRnxKk/ASamtrF3ufCa9ZV1ApIch4xDQCBZBLsYd9efoe9hLfpfO
 ZtXmGLtOpjKoKGHCaf7czsseqA3+Z+AzKcRz+BIx4fu+Dm5YOWFaAefT2DIEtYQ53yI7SzOeScgc
 LdfEIZT2/9xkfdi6f4HBxj5hNfs6lFfXV6hdSr4tgWslQlTPdbT4qXAiesT/tYtxPh0PxrzlzNAs
 LpTRGZv2VeLdNkVB81/7XKN3lIvrK+NJdgUQ8uo/60knoRcdGWn47qOgwE5dPuW5ZtDtLwDGNaSy
 W5rb874duTQlTvPEK1uvrHOttosw+60tnEALzb26cJulkLyazOmRC2atX4KQpqZ6LZULlkZenuv3
 +9a++SZYCX+jMp6+/AI3AALS+nCrFtEhSLv0dpeeys1Ta0PdovZ1usKBLOD/t1ksN5oJ947R3p+L
 SXqYG9/Cbx0zwLxiQHw66hvZRhOJH2cdgsKz5eDHCSGFqeSZPZZb8CuhGyqNuvUn3/dF8+FIARki
 qW/RjXLw27487r7fs5+z3Qhqup9IpXuQzBHwF4J3OjFx7qUhvLWfzCKPFzsGTN5Yuy7obUaHhjVk
 9tay0q49XEK2sHszxoMJwoldsxmmIc7QmQEAJLTIUxq3X/g+02YOYGK0yaYRgrOBZGMpn1plqK6l
 UlJduQKP0+R7wvejHSLv/SQhye07wGFmuMklFNMIUf1BeQo2RyPyzHzgENi6eTO3U08SwuxU+Zcv
 3+N3HdRICtakMbwuYOMAmvbNKqkNlMurmG0ECUtyIXa+fai8qM62VaGblxTRHH/roqBY4qw0kHDu
 rKNxsGY7g=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: hanyuan <hanyuan-z@qq.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [v2,1/2] cli: panic when failed to allocate memory for the
 history buffer
X-OQ-MSGID: <9389FB9F-FD0F-4C6E-8A3D-E272F08208EA@qq.com>
Date: Tue, 5 Mar 2024 13:44:57 +0800
Cc: u-boot@lists.denx.de
To: Tom Rini <trini@konsulko.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
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

Hi Tom,

Sorry for disturbing again and again. I have sent three v2 patches in
total to the patchwork, they are:

[v2,1/2] cli: panic when failed to allocate memory for the history buffer
[v2,2/2] cli: allow users to determine history buffer allocation method
[v2,1/1] cli: compile history code if and only if history config is selected	

I made their change logs very complex and their relations are hard to
understand. Please ignore all v2 patches and allow me to resend v3
version series, thanks!

Regards,
Hanyuan


