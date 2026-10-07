Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3FECA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 18:12:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02AAD60BDA;
	Wed,  7 Oct 2026 18:12:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id On7OFzJ6a6vi; Wed,  7 Oct 2026 18:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9EA0260BF7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791396726;
	b=tbnpwvACJeMaOTrMl5aUhHzSve3ChuVNeCFtGTHBpILV+1Bz5YhXni1LCu+YTinB0hvu
	 FgsfAMXNeatTX51bDMjkizJKTwNfqdlbI6IBIjIieyBE8ssE+uS6RL9y/gLI2Lx5daDjG
	 qGX/3UVv7MB+x7W2MD8tZWxFnG0KP++NWgk/JzqWjjRoOmABs7aLZUO8KkUqTwrqFPmMz
	 LyYCr9UDTNUcbz3qDDX3WX/vTL5acmsmOzbXFm+XWwuo3CpZ6KXQIVOqtTS38waAJCY7T
	 wGTrXQikbDS9N4iP4bARyRfM/6GzuJA1qBDh1dV1av4qTFeoGG7cwntZamxt60FodPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791396726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tvMUP6zXXNmOIBi0jqaiUwY+rHqeV4t04vNPRY051bE=;
	b=JKWrzVPFYmJFdy/UlUsuKnWhf3lKQsVldfnDRIsimb6pjkdZo62EqaPcUbA4c+vPLBiA
	 BrKLYi7FcaedWEtWBjmUE6s0Vyq0MhD6pwb1yIR7RKM/1OurLNwGqMp1I9+ydtISx9Gb/
	 qReXXXh6rSXu5fcK2HseTU0H5MP3Hxp9zpFipd46iZ92p/rEovlbXGjjEvo6aQwtIigJF
	 xIKDqCGQSdDbQ0jdTsQaA6YR29DXoCDuSV6R3yZG38AIJiWqKNS4OJquu+vEHrKR6Ws8g
	 /kx1tLO4M8B86Vl4DJiFVrPTqvHTsXGlo9+jrRSjOVmu8WEFThhdOc6n1Nj5rOMg6aA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=avmlgMsu;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cb4UDwUp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791396725;
	bh=tvMUP6zXXNmOIBi0jqaiUwY+rHqeV4t04vNPRY051bE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xQYOr+YtresAaLlHxnr5FvCImSDMpKEPhvMT57720TOdwLg6kethx6wYYqLfx1FWO
	 jfOnNCwA8Hr0wQVEbt/z2tK+wUKaP9C7jD8Vk8nVFHqN0RwyqjMdbLm2lq1xLXgjc0
	 iDQ7+RMYUNV1a5FdnEk5bRy1jGCpRcc1U1STM0i5FDmQJBuTbHhnS757uvEZPhdwkv
	 7EiramCWJGQmibEhi1VB6CFtOTJ118maEGs7uy7hBU02UzQgOqKOG2GI61f4lA7uBt
	 G3ciyneXy2zlPMC8rJ2NUl50hbQiBRLSravRw1drRs9Jxv9MtL2Hj43ewynn/mR1Z6
	 PHa3vmCWex3kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EA0260BF7;
	Wed,  7 Oct 2026 18:12:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BAB9832F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABA9A617A4
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6z54VZ63HIoz for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 17:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 060AF6167B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791394973;
 b=WuJhg8N1znUUAk0zwhaViAx52V+YIZmM/RpsgChif8JoL6+IhLqJzfGn76LT/zZVYNWB
 MRR8Y2oZ7vQuY0bC9bNCjZzUMZRIxIQUsml//u3/NX13kQ7CfzHR1WRGmiOpX/ETG5PiN
 dvawvs8+ZQ5atqzuKBfEt0Tj0BWxzjUJMUzn2DPX5KkGD9vofXzTc4wemRy3nm9sUqM7E
 H6x3zR/I66tQrrFuolX5sl0z5Sy5r4QpH49sYcFNluUNqKT2feFTlGEganBdHEhpXCqrh
 xDU324b9TIy9UgrJLrsF/C2HwBi1prYttPEITSwicE4BZ6Af1Bth9+Gf3EVCNcrdNUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791394973;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=tvMUP6zXXNmOIBi0jqaiUwY+rHqeV4t04vNPRY051bE=;
 b=km+kQAwY6M35HW0qh7TBM7qLQFhAT2TyKfQjyR6vJFzm3gCI1PIOryebNPU8TIamH48b
 Hhva/sBhKby/aWmxxLZ7sPuevyiy1NLeNs5UVE5ubJHkCdWQ9ah4wWIBgyYiFy/fZxBFP
 v08irUc5sLLivKKroPnVbS0y+ao4HFROpBWgxbIfmJyrIzEYjeOQuReiMoKLFPkcBeDhr
 OqeKxz+1T3Wih68e0LX4fTqILEG1dgk461fOT6/5+OJUFxLL17V97ap9JUfOa8z4mfBzL
 PIjyxw6lsARS/DYiBI+IspdO4gzHoW0qYQzFC3LKFLuwaJP74XmBtwNdaWbAdouk+Wg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=avmlgMsu; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cb4UDwUp; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=avmlgMsu; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cb4UDwUp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 060AF6167B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:42:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtMIp1059943
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 17:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tvMUP6zXXNm
 OIBi0jqaiUwY+rHqeV4t04vNPRY051bE=; b=avmlgMsuWJUsWKleLJoMDK9TP96
 JwRrkypJ9t7MbL37+MVGwXuh+zRxbaSQpsdaRMemArqercD+fw42jXLimvdm2slU
 JppGCZPxt3OxR8vNbDhJ4PYMkg7XjWOx8/pM4icwjxr1uy/fgF69AoUsvVtpdyxU
 WePQkA6sV33tL9pGwh4tNfXcRXPPI/x2WPk9h9e6hb3Fk2c82Z+OwW0aIvwde0/d
 TOuFcnp5rTd/1G0FUVy+ywedHfzX7IfXFN6QH0BchZPYhAGzavCjLJw9xvKhfcme
 i6Qdd5NyXsszXeV5DMubQsOsUnfmfEawfKpcVVNSvg4fkQAWNgCVgn/7YNw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc5ar2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 17:42:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ef0362d95so8047809eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791394971; x=1791999771;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tvMUP6zXXNmOIBi0jqaiUwY+rHqeV4t04vNPRY051bE=;
 b=Cb4UDwUplFMICLK/zyrYBffT9ICM8+/R2IGkDI+nEPFdf+AVQ7CM4FIZ4kevV9z/m0
 VFyALOOlvzJtvskgoTMoEN9C5ABHnZRrXXO4UUkeb44kN8WlJftlwf2WLKWwl+Lk/O1i
 s3ZYDu65TxJJwvJfiBbB1QDTyVAXqhTeA2pMDGNKUWonX7kiFmfl2L4fJtG/P4jWoaIx
 DNgqazS+R0Y+dVjystliLl5mziTgR2qZqvo/8d/TzInGPJcywl4tuGi0/VVlR6rn3nm0
 LLwGdMnAhMG0SqMfmm/uUvsyzxiGASLO08vFQU8mNTYg7ZvHVWOBJOgcKsNHHjjxk/t1
 gerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394971; x=1791999771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tvMUP6zXXNmOIBi0jqaiUwY+rHqeV4t04vNPRY051bE=;
 b=eq0OqERFXbL8lIwhQ4feWhvkKjyCNWF3sC5zko6/SX2uo7NXM5wpWhWv79NOMQdJVf
 KpsgTlBOHeLe/Pf3kUTV5OSnI289EjPUuMIjVyuqWrCRo+FghHF6xUhfgNrTUfiVsk5M
 8IKe7l65SoSlXv/alV70bsMtfd9xcuTSIs7r7e1aQanDw9b09ECbF9aKNOMohNhh1rXB
 wv0Ge8Edl//01wNoFzXe0Y+K41rCHyYGqOI0++4GszFu9K6MDkBRE60tauZAJ6+5Rnl8
 I6JO2yGtOPhlVxxXlRZCmg3PKp2hKIN5S1wLK4aJNnK6jVF8xs3KGRaSZgRtn3KepJKN
 YwTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylZogMTZ7bsfc/NlnRlYnSDD8L342jPGfL+qkSeHGrdVYFa+yi+SAVPMeGKopr8RvQN//k7iU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK/+11xEkL5J4oxVis8BgA/+Rxjnn2aCzyYIQgIbyF5NRgONWEZ
 IqkkUCeoCadqBfYSUm48J3wb9nGvtcw8KvUmJvF1cNOVmyDAl9J9Xs07lFQ+46x55ZJybPviFGm
 gt/jZt6cmNKJn3evs42ZgxqIhK24CzX3OXlsQQ0I5Je8kT0hO7tM43QckJHvGW5HFKZc8RBQ=
X-Gm-Gg: AYBFou0cUE85F636Udow9So68LTgtkap7PsLeDbBeJ5T4gOxBaO5jnr2X9Xp1sJjce1
 frH0/oq4xAq6X9DrqeRTuld6s6jukl88eQ05K6TKmXoVXsYPriDUoyftWjpb4Kf85XmXvK70kHX
 ukORpkCJycfIs6yFZvON6HyyQ8eEX9mcn1f823lFsi0L3ApYzAkYPy+dgx9TRXEIcKFZP1RUlWm
 0Yoy1BRsfggKh3nPpqUR5tsvyYOXtipsUWkNDFjPDVGvqglBY9jY4Q5WxiZaTBW0PAzDS1QZpk8
 NyzhIAK/F5oJShXxhL1w3PGgowE3K41hz2QhT9ZKaYlMCSeFVaKfSOLdR1Q58jUg5tvLkP3M51h
 d7o7Hk1DtdHPK61Wdo6dX2gljsXIAAVQHpnYM+y++rVF0TIUguWMd7/Smpo5EUDeoO0EFT837kx
 9qqDrde785yT0THwbFVLHSdLFkSqWWl8O9ag==
X-Received: by 2002:a05:7301:5408:b0:351:4f5c:c6a1 with SMTP id
 5a478bee46e88-3515dde0918mr3051108eec.26.1791394971123; 
 Wed, 07 Oct 2026 10:42:51 -0700 (PDT)
X-Received: by 2002:a05:7301:5408:b0:351:4f5c:c6a1 with SMTP id
 5a478bee46e88-3515dde0918mr3051066eec.26.1791394970416; 
 Wed, 07 Oct 2026 10:42:50 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515abb779dsm8486756eec.1.2026.10.07.10.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:42:50 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, hs@nabladev.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 5/5] configs: ipq5424: Enable GENI I2C support
Date: Wed,  7 Oct 2026 23:11:51 +0530
Message-Id: <20261007174151.2590649-6-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX4zqUmBk41gvC
 M0A7MEPssIGLRCjfTj90Fj3ErcW3/7/JBsE6dZCplchj9D60XDIpoYUMsZD5FeFlNVY2H6Ott8t
 DMA+Q3un8z9yYXgWFEz4hgTiF1+g+LI=
X-Proofpoint-GUID: sMN-KBYAK8I_pDZIMKwR0A_X9pItirly
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX9rnko+v2C8QU
 P4/as5iUmnBCezucM+WDDoAca2azAiKUcPDSsNibhD+WYElFttATtfrAMKRmkjXE8cJYSTgl+XK
 SzzWGI8oBXyuTDArkriNVcapwI1Cl0H3YwlzxYR2zLVOf39vaFmcZkUmu6He/sXIDvRw8QVXU5r
 ZuPdTMmk8bmYlNat3xNiUJZndCcQNoe1eylCPMxP0lBCF417vb6miiS/mbkJjI4x4YUiRTNSmIh
 xjIYff2IpQoqHtFeABBqisnNa2WeZfwVzM1TgzOelkhJfym6mGgZINkW7KnCTP7K6YKHtL6W2+S
 oHxuyyt/zozLq/uVXqP7u9LC2Dg52wp+UHwYD8Wci70tCPjoTNJLpTTngzX7L4XNsiPwZJSGAL3
 AF6uLn9oZZ0gHb0VVCOR5S3RkhIiiwXBXL/o2GpPImaffP8KLfxkavlM4ZNx+0bXdZSSrpMiwjP
 11AFahP+2wWMF4Ybu+w==
X-Proofpoint-ORIG-GUID: sMN-KBYAK8I_pDZIMKwR0A_X9pItirly
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac6849c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=yuJJpEuAe7blWNTBBiEA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070070
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

Enable I2C, driver-model I2C, the U-Boot I2C command, and the GENI I2C
driver for IPQ5424. Enable GENI minicore support so the GENI serial
engines can load their minicore configurations at runtime.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 configs/qcom_ipq5424_mmc_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
index 6579d7e55b0..ac98f0d4520 100644
--- a/configs/qcom_ipq5424_mmc_defconfig
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -28,7 +28,10 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ5424=y
 CONFIG_MSM_GPIO=y
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_DM_I2C=y
+CONFIG_CMD_I2C=y
+CONFIG_SYS_I2C_GENI=y
 # CONFIG_INPUT is not set
 CONFIG_MISC=y
 CONFIG_QCOM_GENI=y
@@ -36,6 +39,7 @@ CONFIG_MMC_HS200_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_MSM=y
+CONFIG_QCOM_GENI_MINICORE=y
 CONFIG_MTD=y
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
-- 
2.34.1

