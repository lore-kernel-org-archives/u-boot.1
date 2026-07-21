Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B92EC4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 10:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41A2B607F8;
	Tue, 21 Jul 2026 10:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XcCjC_jB0fnq; Tue, 21 Jul 2026 10:59:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59999607FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784631572;
	bh=cIilDmaZeyQ194rNfnDoB01WzxG8L2IKj3KHwx3x2qw=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=fTDTF9w9LOKTHafG2/jU2mxL2l9GSggrKDsc4ZwSKcJSODI0hIJN3eXoEqpmjAgWu
	 sBYcmR/nz+hrKcpy0yQS8YlXkNTrFFb+YGg1LUrjRrRtr2RtcdH0UOVCWgdVy937Ir
	 EmOH3U/YGgzD7Bw4pp+SzJC1RjjWEePt08EJHzmCz6Qy6BZ4AAqi/mDQA5zTVdp3zm
	 1Xswsz0KrGJRidGKNhJdasRBQIPOFRKemEQcP8WafRLId84Ezhl294VIARMiQos2ab
	 J4dekhXiIVZbKR+akT3nC5nnnyLqwaUnMoGKliwBkjB0a3pLfWuB1ZNOLXGsWVsA/F
	 7laFAt5KYIE6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59999607FF;
	Tue, 21 Jul 2026 10:59:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 849879E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 10:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 767796081A
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 10:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lauiIUIesNPz for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 10:59:29 +0000 (UTC)
X-Greylist: delayed 693 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 10:59:27 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9EFA1607DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EFA1607DE
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.92.25.143;
 helo=mail-d14.seohost-mail.eu; envelope-from=krzysztof@kd-solutions.pl;
 receiver=<UNKNOWN> 
Received: from mail-d14.seohost-mail.eu (mail-d14.seohost-mail.eu
 [153.92.25.143])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EFA1607DE
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 10:59:27 +0000 (UTC)
Received: from 83-168-76-203.static.ipv4.korbank.pl ([83.168.76.203]
 helo=[192.168.1.202])
 by h74.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.3) (envelope-from <krzysztof@kd-solutions.pl>)
 id 1wm813-0000000Gkcn-3rGm for u-boot@lists.u-boot-project.org;
 Tue, 21 Jul 2026 12:48:01 +0200
Content-Type: multipart/mixed; boundary="------------k029uob0UPI01ZBs6nWQ3dOs"
Message-ID: <b80b20b3-1d30-4a2e-81c0-d974f91f48c7@kd-solutions.pl>
Date: Tue, 21 Jul 2026 12:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] power: regulator: ADD PMIC PF9453 support
To: u-boot@lists.u-boot-project.org
References: <20240930035531.27079-4-peng.fan@oss.nxp.com>
Content-Language: en-US
In-Reply-To: <20240930035531.27079-4-peng.fan@oss.nxp.com>
X-Authenticated-Id: krzysztof@kd-solutions.pl
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=kd-solutions.pl; s=x; h=In-Reply-To:References:To:Subject:From:MIME-Version
 :Date:Message-ID:Content-Type:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cIilDmaZeyQ194rNfnDoB01WzxG8L2IKj3KHwx3x2qw=; b=hUyFuxBXtNQEVqg/Jvol21Huti
 arGAYQ5qsQQrf11dzVwxGJrULpeJZ9vdtYMAqXIdOrsvtxvrNaI0vuMWpsEnou2TWmPxL2YTDJc2i
 OWU1j3QYwMyceg31KAxFK93fZCvUJzCuW3yB/lHQ5srenVdb+jh4Ipp46rZ2+O52bCnPW7jDnkdP1
 QnZDfe4tokZTr4YlmXryXTbljQqKyFvTlV30kOG/A11Ey5uMT+IqaRWzDufTPsNby806mHWewbO01
 kA6VbzAf8FliYhEhf3vQYB0Y5oGyWcKjNQcGaAtb+YyLWzVjMv28TLvYdiPDRcgxrPs1AtsXUqJnr
 6sjlHaHQ==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kd-solutions.pl
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kd-solutions.pl header.i=@kd-solutions.pl
 header.a=rsa-sha256 header.s=x header.b=hUyFuxBX
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: =?utf-8?q?Krzysztof_Drobi=C5=84ski_via_U-Boot?=
 <u-boot@lists.u-boot-project.org>
Reply-To: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This is a multi-part message in MIME format.
--------------k029uob0UPI01ZBs6nWQ3dOs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[1] is required to fix PMIC access on u-boot 2026.07 then both [2] and 
[3] works fine for me.


[1] 
https://github.com/kd-solutions-pl/rozalin/blob/main/meta-rozalin/recipes-bsp/u-boot/u-boot-rozalin/imx91sfrdm/0011-power-Fix-access-to-LDO-SNVS.patch

[2] 
https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566287.html

[3] 
https://lists.u-boot-project.org/pipermail/u-boot/2024-September/566288.html

-- 
Krzysztof Drobiński
Embedded Linux Systems

email:   krzysztof@kd-solutions.pl
website: kd-solutions.pl

--------------k029uob0UPI01ZBs6nWQ3dOs
Content-Type: text/vcard; charset=UTF-8; name="krzysztof.vcf"
Content-Disposition: attachment; filename="krzysztof.vcf"
Content-Transfer-Encoding: base64

QkVHSU46VkNBUkQNClZFUlNJT046NC4wDQpOOkRyb2JpxYRza2k7S3J6eXN6dG9mOzs7DQpF
TUFJTDtQUkVGPTE7VFlQRT13b3JrOmtyenlzenRvZkBrZC1zb2x1dGlvbnMucGwNClVSTDpo
dHRwczovL2tkLXNvbHV0aW9ucy5wbA0KRU5EOlZDQVJEDQo=

--------------k029uob0UPI01ZBs6nWQ3dOs--
