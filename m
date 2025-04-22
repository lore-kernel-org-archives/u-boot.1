Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A88DC369D6
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 03:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8446B8129B;
	Tue, 22 Apr 2025 05:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QSXpRDoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3221180F03; Tue, 22 Apr 2025 05:14:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32CCD8056A
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 05:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745291634; x=1745896434; i=xypron.glpk@gmx.de;
 bh=oW6jJAVMt+XOHkQ6j3AfURtSf78MH4xWB2CQze30ZZU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
 Subject:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QSXpRDojdtxOjuJFNrks+OYEJ30UwNDY9osvXbOqFAshrxGGd/+KBYg4CjbZNY6l
 Co8X5ubNGefUjAnvyNsbh8aWyDHxW4jJhJhKeH4O4UcSpcBHEw1OFP8S2mWCQp2Lt
 XAsqPBHmSVhQYtaqQs7GtvpvwyTtprxtlLt7alLOYwQbcqT06aHG67NtcsFpbC3lh
 9JvZ2HSpPeGaK0f5TSLt1i7h9CY0Rb0acLZdzfmLmmEVGT3j3oUkuDmJ5zKHs6jdR
 UGlIc/cyc794Vl2LckxOCcN2zkCKmJxqPe8lJZ1HcI84wLdNUn9KEM/v2j5nBSfgm
 DmsGlxngbn5ukrAWMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.105.52]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1upEaQ1EYq-00nyBe; Tue, 22
 Apr 2025 05:13:54 +0200
Message-ID: <17f988b0-787f-469b-8602-e324e0eae8d7@gmx.de>
Date: Tue, 22 Apr 2025 05:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: NET_LWIP breaks common/log_syslog.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vRUVoN1UPNdTR8u6XkqhIdicDmxVMhgFixUHxZzdhG2kW1m7Fy9
 kMp1Qf2FfxV++RShOpwYHcfjhKiIjE3B51Y6QNey5IVKPP3IdjiZlrGyIYWuJqm5Z5aXvEB
 dYEHa5ClgsDYteeJuR0Vd0Y92Uo6zXCuQrECnMHPCN4H6mlKDl3CKz+wDAAtNolBDzS67CG
 qDfVjpJzYtB+hhzGBv2/A==
UI-OutboundReport: notjunk:1;M01:P0:fcqTI7kv4u4=;atpRvpGORe93BpmPSwNz4QB/2IK
 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
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

Hello Jerome,

I am trying to compile with CONFIG_LOG_SYSLOG=3Dy and CONFIG_NET_LWIP=3Dy=
=20
and get:

common/log_syslog.c: In function =E2=80=98log_syslog_emit=E2=80=99:
common/log_syslog.c:59:24: error: implicit declaration of function=20
=E2=80=98net_set_ether=E2=80=99; did you mean =E2=80=98env_set_hex=E2=80=
=99?=20
[-Wimplicit-function-declaration]
    59 |         eth_hdr_size =3D net_set_ether((uchar *)ptr,=20
net_bcast_ethaddr, PROT_IP);
       |                        ^~~~~~~~~~~~~
       |                        env_set_hex
common/log_syslog.c:102:9: error: implicit declaration of function=20
=E2=80=98net_set_udp_header=E2=80=99 [-Wimplicit-function-declaration]
   102 |         net_set_udp_header((uchar *)iphdr, bcast_ip, 514, 514,=20
ptr - log_msg);
       |         ^~~~~~~~~~~~~~~~~~

As these function just prepare packet buffers, should they be moved to=20
common code used both for the legacy and the new network stack?

Best regards

Heinrich
