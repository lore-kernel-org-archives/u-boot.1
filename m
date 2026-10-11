Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B408CA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD3B26067B;
	Sun, 11 Oct 2026 14:42:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 641Qr1mUCfyE; Sun, 11 Oct 2026 14:42:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF2F760622
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729736;
	b=BHbZBZBTfsO87aWk30JpT4rZpDaKs7P+F0FVLrLWU7djJxYdvlnhoZASISgNAfeWEgMx
	 icVkCF2bMJ6+KnGZrwx9nWJKKFKZoJx8IM7cacMTXEdlHmfSXVaMta5KZlLRWlIGpRpse
	 XhmdzgMjekwkS4PF4nO/RKOWX6Cp8bxodVbjs2PSaDF5PDmik92fwXL08E9rmjFE+tnYM
	 +wrs+Y8JuJSETaWzTnDgaVJ3F/cPL7qApcsJ3P1iQEx1Oke/JArDsIGyo+Q1EGXPrTond
	 g//qUX2Gm/r+bjxKfOo9cZeKuGv7kgvPEkp0sZYxL876qBjY/U2paDFX0HePi1X+ZJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OWrc74pPH2iG9KXgTVQ2aQjKVLkkH4phuyazTKms5qU=;
	b=PThftFautRdY2YPEGvmRJ2Bd4AjZ4R3h3NNB0zqSTYui4f5QWIgzRByYegfQxyWxvyrr
	 IV7d84zDoKy/mElk3GQnUrwkKEp9AFcv4i2S4BzHsDfHKC16b/4ioMc5k38lvXaFCSy1s
	 DOCl1mdEOF83lEoNJH5FigGNX2ur9nWluPgY96ju/YHcW8G5i4/oPC0FeYyvOMFt9AvTL
	 q9M55ahvKWV7zkXXGXHvwA5Y05P0OJz4yXqH8z4LzI3ctPbQ6lG0BdICJ7fBFIYfY7pO3
	 BAgSlmgPKKWTbX5QnZeBAI0l3zTc+EM2DSkX43IDrxV8WehudAdJVS+ZVmGKHsT1uTQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729736;
	bh=OWrc74pPH2iG9KXgTVQ2aQjKVLkkH4phuyazTKms5qU=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hBjp2KLS9F7F5kYLR4PNRzhAFyEzIF5cjk1ArzosfnMnrcXO5gYLzciJUc4OLc1Ix
	 QmHDYZ97V8XEJ4zDI3NDbfceVTM0HudKKHFxby8TSIpWZmqO2I3KcqhJ4i3FxXGc+G
	 MtzRjAlqVJOLd/+Md2IAJdJPfPGigjRd1zVPVKDZgq0/NkeXzHxcVdlWOwWT5c8KQZ
	 r6pFhQEfZ8RJWd2nxLIJlYFpp6xGD2WnhSNm5AB77TznUZnFonsxf0bjEhj9J1Qh76
	 f7YtBkYTGVB5MwxbrBwkDvVt7LrJSjqXjugVK9JyUI2fPKjrfmlmPss01vKB1TY8vd
	 xepvgzq8pM8JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF2F760622;
	Sun, 11 Oct 2026 14:42:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A3F975
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7789D40627
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKBVBf5ghkXN for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 14:42:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 574CA40620
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791729733;
 b=K/ZkLcDtKeNsaFqNIGAXEXy0PxvUCOUR/Gfhtf8W0vaxQpLB9F7zdTcLzDdARBqgiEM9
 jvbMg744N2iSOwih9ztYBA9/uqbwcLv+EKhYHAmBmtPxXcagD9BPH65KBDiV4C3LRXF+o
 39G9tDZJ3+NeT7dn08Xf5XY0bxrKvCPnvU/1XPDKXh1rqTvcbzkfe9tkpgMYrvYgGghVs
 +UVkw1QDpN1n7Rk/C8lw95o/sEDsfhjlKNKj8kc09foxIrNHG4wC8W8XMh9JR0EGVaian
 I7vSAsdVjvs1AU66Y8H8uGbd9jL5vliV9XDXTS7B3scbL/h/zAHNlmTUW7RhRd96aGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791729733;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
 Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=OWrc74pPH2iG9KXgTVQ2aQjKVLkkH4phuyazTKms5qU=;
 b=qmPjfHaxnwnVazBZFtNILBuKlYHuUriiOGJ/lrlrGvLDqC+WizEe3tFsiIuoSofTp9AF
 n4CAt4Vo99+rDG3rF9ecm2MI5Mg4YlTyrrAY7fWDfnEfGtg7P5LE2yuIJeJpqiBsrczpL
 pE+JpQXuDZwMGtjI0oHOxKiYH/DigmedJydOD5fRWluPk/xljCoG0Lj9Olg+MnG3hVuqS
 zHXU+OpXrQkfO1OCNUCa93zbM2GyHf06OgeH0dSWGOqIGeYIuiI+4kOcmX5FJqRFKvF/M
 5Ulwo8LLNK0HmT8NdLcM82P55y6gYX3MN3AClEHDWGs/qXPIcxo+/n2MEeruMsCAjlQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=oZJev6Zp; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="Pu/4ZjMv"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=oZJev6Zp; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Pu/4ZjMv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 574CA40620
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B85H9r1512952
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OWrc74pPH2iG9KXgTVQ2aQ
 jKVLkkH4phuyazTKms5qU=; b=oZJev6Zpk5DUvUan6yGBMCkzmF/XVOYrwYi2cA
 FyGJ3jEIQMjU6w2VUvqyx0EtxMTt4t34kE5UwxEvU0WfoNsKYstzJd6IxbRtld3G
 O5NxzsAqxPKts65XitCGofaw0T/3lao1UnNiGKaAb0mJveTQ/UebJ6tJDikKvjYi
 nvXoDwM9yXulvpu5u+oBtXjiiucyZ2NAEva4pm9gopvK79B3NW6e790gtmS8b4Tk
 egNoQJHnPCNnMRiFFK4ATEUEg9IVVdCV5V0eBOrddflSnghpMbaW7PTIrreyMKPC
 xIqeSNxeWpoAKh4a/VQTqiZ2vfRugt0OfJ6uIPCqV014qD3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7ehjk38d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 14:42:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf6c528aso211675585a.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791729731; x=1792334531;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OWrc74pPH2iG9KXgTVQ2aQjKVLkkH4phuyazTKms5qU=;
 b=Pu/4ZjMvcXbJ33trHsg7j+B3xrWfOe1DjyH40QcZ2xpsyFyeNmIrb/VoGJueMGoCXa
 oINz7dskHcSnbXUxUfCvmqB+DjcSfvy9uL7KCpQETod37GEWRM43FvJ6d3XZDTtcN00V
 GNcn5RPi810zrmhGGrEBysQ8w0RvVtNDSTeGJRKb1fJnFW2QQMQAbxaFfsCe0PAqg3mh
 ARg1x2S59YCY+O5+IToSM0YhbOM82hogwYIQYnhEVLQUnBd+kXtVqmJOAzKooRGG7YIv
 6u1a6qVuUSEhagILyP2Yg2zl51GOd1j8fQyJqoKRjztUGLPT2WsDX6jOcdVLYi04Oeb5
 PfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791729731; x=1792334531;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OWrc74pPH2iG9KXgTVQ2aQjKVLkkH4phuyazTKms5qU=;
 b=pc63+CLHx1e/3Me5n+i5f4J47SUfj8VHH7eJzhQ3iThJCtPVfBt2KlvnyLy52VGlbN
 K/HxCveRl9oYZN5UTuzTkf8K7OSOGm7rC8me7q06zPodbSpWjKP43G76KA20iowsEXbY
 1IbmzLBRugXhm+YpCByCRcgQgX2BH61VxGDkv4QWUuETaUEij/icckR7WNTpWm+80R+C
 18L4BHtGQziLRfNaU5r7wNoZBc3wbO6Ob455z2ddSvkMg0/MQVqzdTNzwJBXE7LTr8za
 LfhFRLv71AXLo5LdSFFp9bAk5h3vR4IpsiJwIyPblH6G1McxyPogXoxQrebCP/JdMF8O
 EwaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLDzK8SLQBqJD9umqWhgcTATc3gfNCpqA/6tmSCfp9GiXp62wLlolSe7xpC8FYQlQXeTl2c4w=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJTuvlOB1tMvB/cHWj4APenqe5Xxi+aqUODPvbcN3Mgr6pkos7j
 LDr1HUR5NZY64cDfn+ADJY7u2nOmSDARStGIYstQSovEj7GWlRVzzUeY9Dg7mOip5anW0CTKev6
 9UTc4TQG+91L41BTArHXopQ74DuC7VvtSU6NQ1lwrKlO2XygL3Aqm8tj0PGIYf7v6uR+jGfU=
X-Gm-Gg: AYBFou3qB+/xEgSzysL6BLDUKJ28bQ3d7v2cqYoFmrWUdVp3LROeWQho8fSq/eH1NBV
 sC/acEEvIf2NEZcllIQ8tc91+R9aEziiJTmQ4SkYUOkPVXbLECYJYZP14dZ2XKFjKiXqWRMGSfQ
 8A9lsbiOTPZQFEHrnKBMylHtwRnVeUjCuVtvVHlXX2W935YOqbcBADJS6K0RrGG0wcIfSstae01
 1VrI6uzqok0y5PnvO8/jJF1HM04S5c2S6EuMXBykIdPecf7R3Bmm7VQe0DQuFjNPwvptxJ1Pd38
 DOy4obDqsyLs2YwbZLNOjSSd9/b2RglJaBielDqtx4A9UpcVkvlMMjHstxvJGYiPxwljb/f8e5X
 xYtDk4rdEBBZGfNWR8fanyZXXhSKwqbZfx5XqAjU/x+Ui
X-Received: by 2002:a05:620a:450a:b0:93c:b10:7243 with SMTP id
 af79cd13be357-93ebd0cbfe0mr1254158085a.5.1791729730968; 
 Sun, 11 Oct 2026 07:42:10 -0700 (PDT)
X-Received: by 2002:a05:620a:450a:b0:93c:b10:7243 with SMTP id
 af79cd13be357-93ebd0cbfe0mr1254154685a.5.1791729730470; 
 Sun, 11 Oct 2026 07:42:10 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dc0c8asm3854326a12.13.2026.10.11.07.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:42:09 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH 0/5] avb: device lock state, root key provisioning and
 in-place verification
Date: Sun, 11 Oct 2026 16:41:55 +0200
Message-Id: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrBtIUgmtVylF8jO209ooGSMF8
 e5GXT2+zVuAMREyNNUCCWdiGmKBulTg3za+UFAoBi21UVIpkUeeEtqfsLNr+8F/2xyPuFqEq9X
 G+Ju8hxrKYUzY0f+4P56nObsP+mlfwrpudd1bRX8AAAA=
X-Change-ID: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfX4HvIZ87V+B9R
 BebCxMJAzadALVpWEAERfcdkC53TVPt801LY5XhwT815x1BxNGY2+EnMDLRwrXJvSPNUmULij9h
 sCv0foASen7ed92+F717SY3wXvwRwu/UPQQUqeVZTUCsACHRp6AdEEn673xbr+a/9oaX+Eo0TPy
 kgX/Hl3+i8J2zy1MtfSEh0D/qby3uUGblf1+XapIOJvOQ+ZU0oBzfvj6Rbi1GM0cvs7tG5F/FNo
 K99vHAW3jvLtzM1h6yKb+L+poaxCW1aqrS4LNFP1yMINmBZ+Nsa9LWetf/pXTrDyGWsLmvAD0xO
 C5KP0N2Lfvs4XSygFQJngf017RMsluUKZDjvz4+jofRZUb3Pr7ULnKrjeY5Eb99sZy/dji7pJ1T
 yQdDiFUWU+OQZIGzfPL0yhBa9ul5sqEHibnd3iqE+Or2oB0+plCE3kGpu0SWjFbeYcWvJRM2ZOT
 tn4b5XxcNepNihJEySg==
X-Proofpoint-ORIG-GUID: RRAqxobZ22LMqo2cZk17u5tF1j4oC6jy
X-Authority-Analysis: v=2.4 cv=MpTHeGae c=1 sm=1 tr=0 ts=6acba044 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=g2NrrMGdFzmtCDopep8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: RRAqxobZ22LMqo2cZk17u5tF1j4oC6jy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1OCBTYWx0ZWRfX3J6zdI4eQuRU
 /kbMHvWl5q1HTmmqb4Y4u5wjhkw1dXFrks17E81TphECgmv5Cq4IBOqp5h9GDXROUaqlM8IPUY+
 2CpQgmOmVGvstO1Sm9bTk94VIyvECgo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610110058
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series completes the device state handling of the AVB 2.0
implementation when the state is kept by the OP-TEE AVB TA, and fixes
the way the Android bootmeth hands the boot images to libavb.

Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
"avb write_pvalue_hex" provision binary persistent values such as the
SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
consumes, and "avb lock"/"avb unlock" set the lock state through a new
avb_write_lock_state() helper. Until now U-Boot could only read the
lock state, so a device backed by the TA could never leave the unlocked
(orange) state.

Patch 3 makes bootmeth_android verify the boot images in the buffers it
boots them from, via AvbOps.get_preloaded_partition(), instead of
letting libavb read, hash and free its own copies and then reading the
partitions a second time for booting. This closes the TOCTOU window
reported on the list and halves the amount of data read from storage.

Patch 4 adds "fastboot flashing lock|unlock|get_unlock_ability" and the
"unlocked" variable, so the state can be changed with the Android
fastboot tool. Both transitions erase userdata and metadata before the
state changes, as AVB requires.

Patch 5 documents the root key sources, the provisioning of the TEE
digest and the lock state in doc/android/avb2.rst.

Tested on QEMU virt with OP-TEE 4.11.0-rc1 and the Cuttlefish Android
17 images: the chain boots locked (green) to sys.boot_completed, a
modified kernel is refused, "fastboot flashing unlock/lock" over
"fastboot tcp" erase the partitions and flip the state reported by
"getvar unlocked" and "avb is_unlocked", and QEMU's SD card block trace
shows every sector of boot and vendor_boot read exactly once.

The lock state is stored in RPMB by the TA; on boards where U-Boot
serves the RPMB requests of OP-TEE itself, the two fixes in "optee: two
RPMB fixes for RPMB requests served by U-Boot" are needed at run time.
There is no build dependency.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Igor Opaniuk (5):
      cmd: avb: add read_pvalue_hex/write_pvalue_hex
      cmd: avb: add lock/unlock commands
      avb: verify the boot images in the buffers they are booted from
      fastboot: add flashing lock/unlock/get_unlock_ability
      doc: android/avb2: document the root key provisioning and lock state

 boot/bootmeth_android.c       |  73 ++++++++++++++++++----
 cmd/avb.c                     | 141 ++++++++++++++++++++++++++++++++++++++++++
 common/avb_verify.c           | 103 ++++++++++++++++++++++++++++++
 doc/android/avb2.rst          |  69 +++++++++++++++++++++
 drivers/fastboot/Kconfig      |  11 ++++
 drivers/fastboot/fb_command.c | 115 ++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_getvar.c  |  34 ++++++++++
 include/avb_verify.h          |  39 ++++++++++++
 include/fastboot.h            |   3 +
 9 files changed, 576 insertions(+), 12 deletions(-)
---
base-commit: ed869863c7e2aca50d57a05d843830dd843138c4
change-id: 20261011-upstream-avb_lock_unlock_b4-d3a266c809d4

Best regards,
--  
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

