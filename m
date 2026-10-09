Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2730CCA6012
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 01:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D337381258;
	Fri,  9 Oct 2026 01:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TcCtI8QDDWku; Fri,  9 Oct 2026 01:42:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AAC081218
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791510175;
	b=N33FB/2wowZei1VirjYSTyKEXOQe/U5roNFPuWv5N6Fu+1a5QjnxHNGbC2vYshsvkDXm
	 skZCHkdJ1ZJRoKqT8JMW6CxmJHhmtvZeIn1mRVVgmItgI+WXoHMFXq005qoyd1WUXQZMd
	 dtCpXMeh7n3CfOLk7v5SjnukTmVDQykoBhrWOUDIuWByjJ9vs+nzpr53KSxmcVs03kExA
	 t4e6AVlGhWNoYZ1MiC6PjmKp/7scaYAZ0COKDoIpdwn3U6d+SuM2dgJhnOw2tqJ+EkCIw
	 kR08UecTopQUgyozTiTbPNkAs40m48z4Uz/ks7jUspl2CEPvbbc5362OKd9j0HGcNBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791510175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ut0J9O225Hf2MSAXwx07nFCVYBjfUx4A/bb27Rtq9RY=;
	b=TdCdTfZEBkLFCN4DhEsYIT2NOq+g6fYRlKy28ciyOI4f8z/2xNjGQ+VOcmrjWtkEKcl2
	 Mo4Oh6DhJ5MZoe2AbBomFHnaYCYhReYy/ZmU2qGIHZ6xz0d6D+vNTzQMUtBbD8KRPFJzI
	 wk6iH1qEiqFC/FAnEuCPQxEXKR3itlNJwZXRo3dLi55DPuKZWCOZIt2Yvb1k72Cgj0+Nn
	 MMYK3TV/UURonLPBpRdRrowJ9R/x9mXYqjDYAmPnOQPrv+TPra6l7T00UgRVzGx2P0bEu
	 yjNuNg9qnlSV3Mzejkh8V7X1Mmc4xy28B8whgnY7fBNDXQ53fWuFIBN5i+eGn+auwYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791510175;
	bh=ut0J9O225Hf2MSAXwx07nFCVYBjfUx4A/bb27Rtq9RY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pUMoF/DqAsmebEjqi6UlOJkb21cesE5ZCzfUukEhRUangKuAHmRZmorOKO29NnsOG
	 tKZgJGpcYaiKVpH8EKDJ+PSpj7vBTW8kRaTCM+xSNlXA75FZOCus/oMdBAsnc1ujpX
	 CAin0LJnHuXCc/3B939+abtzIW7f6MYu0awmlTVeXe5+PE/AyO59WPOZzc2xe1HIuh
	 de1KOIiw1yMrF/zfvhLDxWDxIKkRtbnySoh96jeoyrE8H4sxWTRNqvmoLYiSqAureU
	 TuRKwIqktsFkWIbGvfrGjIAfnUitVwpOY+hwWZeUEIacLfn/aXJCUEU+eIOzUlHOb0
	 ZG/GEZh5cMx0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AAC081218;
	Fri,  9 Oct 2026 01:42:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0484356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1A7C6068D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lz_k6I2OChtk for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 01:42:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1AFB560680
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791510173;
 b=tC5c/V8fnCxuuwNzMIwrILrJ+9aod0edEgAjQ01PbDfdnAmVZlabkDG2vVaeV2ijA6MS
 sKXQgq/Vl2LsSXjwNuxeItI2U/ue1JkirIg31Zx4gLGJakOAWd3vXyVRcyqiWv/KSt53b
 xgHn+prx8xMH9mcSfEtTR/cG94+/Zm2d1nYi8KDVId2uubtdqAKvKZ59vB+Ga/ZQa6jk3
 91LkVTqFxKp+GH9SdGmks/gX4u8NTpnvr9K6WSrOYrUXGLS75O2fhpAm51h8dUIQXlnMh
 TH46RwYWUPtlEoBI46bpA2zz7COEyACIWzb9T5cckxvtBMyU5TlwFO3twS7avJZ0vGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791510173;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ut0J9O225Hf2MSAXwx07nFCVYBjfUx4A/bb27Rtq9RY=;
 b=SuYSu4jtcm750bghxmNTY3gkqpi84JTbjeUr4ul1BF1kksZN1mvsq8pafKnCwla9Hwso
 1o0nJYOz2EEDYVcMPmYHHdkbPwVvmJ1mcTtWdZoPDJX4gZ32PYCr9WVqOiMy4t58g1eoZ
 r51drNDfVt0UmynPqb2CRbJrQ7D5IwulvthenXt5/dgN3gTKn2po/ttdoD1XSahGIRJZq
 4WbAObjtqvqpeHEroY+W5SL6qEAwWrzq/PlutIC9WYxMIlk8j5dS8YBHlaRuJhBCafCk5
 E8Dacql5dkjfRIhXbNcRSxe4e4Jv/jvz/MCwPSlVo2Xo9vfVJGe6t7+bTtf4Pos1sow==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=MIw9Yxx6; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MuRZRjj4; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MIw9Yxx6; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MuRZRjj4
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AFB560680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 01:42:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6990Pul0230806
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 01:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ut0J9O225Hf2MSAXwx07nF
 CVYBjfUx4A/bb27Rtq9RY=; b=MIw9Yxx6kUqS+eqBxNTORYjXR77j2011ggiMzx
 eEnFSqhdFhEEJBezKWMHBgWbA5gpET1kLtYAzbTU7qQ9lL9R+bpiwroxK00QQS/q
 u0tk+IpbVUU8GgHTZkIgTOV5scDwU7c+/I6YBSCkdc6azDmjPtRM2CPWpUVKUfvX
 uwPMQ/n1U2PE9zwVFRF9pVYoIDmwLbXNQDJV98L2TS/lPGbyD+2xw/hP0NGM5Pi/
 MZhvaxmtQ2eHRHcrjKomprCmLR4gQtsIDgLV3DVZTjr8TeO10bteJ5xGaLIMKaPC
 d9yeOtMWPDWoUoPHFk07zpL9amDyW2XBrUHvJ+UgGaxCFKsA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6baj2jj4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 01:42:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3515266f6eeso3167888eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 18:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791510171; x=1792114971;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ut0J9O225Hf2MSAXwx07nFCVYBjfUx4A/bb27Rtq9RY=;
 b=MuRZRjj4QOkaIBRXUfuoIVkLOYo6yu+UJoGOAHYWG3jQXU4OHuXE+lupZfC81ZOQ8B
 CccmWM8yaHoYkUI8skNoIBnA9MMfRp/txmm3yoBDr2ffHpQ5msAvWI/NIilytM3bk6tj
 AldjgfRB6JdTfEiEjPkNx3HP7oGrIlTOTSBtflCqDlIqPoO+Vng9AoyG09d936yKiybl
 BrN+WLb6ClLaJq/lnhdeAlvhdGxefM/q2LIZJSr63UWgIxZ+Ris1wnJ5EJVbNx54i6Ui
 BwYAG/mBDey89zWqPMQu7WWlmtbzbZLdFyKfVkGgRHkTdiLvXg0ZBF7MGNJ65QRr/ha+
 rwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791510171; x=1792114971;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ut0J9O225Hf2MSAXwx07nFCVYBjfUx4A/bb27Rtq9RY=;
 b=K5C38MXIC/y6j1lX8xz+2HVuA5tCD4EJNWq4dF4Kdom5fSYJKQjKkbIH/BgWvwUr04
 SD8OFOUD/jsMey1FEFspzFIKXP8ZzuDlyv19k2ZPkl7bIxzqyqLLN0UshD2C6l0f3Jsu
 5XFZqaViupUv4UVkfxilzZakNaHK+htKH8GL73tq0Kf2QNCptDhnnSZ5UoA7jzA+4P+w
 LAgQssxQlVjc5HqTpncRdt3ajqLuoVB6XpKSQHRE0B6EZ5qneG7skEZZogXvvN25r7Fk
 n3CSh/QLhHx9fFWdre+LA+qKy5FqQT7wq4Zj6Nn5nGxYhzBENejOD9+uZ6pSe8sixV+i
 g39w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbbuhSMefgBSoHcDNQiyjsnRSL9hTGKBWI9JGM3WU/16JhI14D4SrWhGtxFUfGIUw0URgxPxY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kuN9Tky7urODinhJhufL/Ii3ZPtn3dpZU0Zq8pdA0qqn1aP/27
 63mckZbGCO9VGkR/nNYJn+M/gCVRs7QGhGU9pbSaVS99PdmGpmeEFwQTvhYuGuoCLAOZ2lno8t3
 Uf84LChb4OMmWX6kE8acLNHyw4Z6Po3RBX1uWUbXttiwkbn1InvnrVlK7C+F8AuEOv4zqbAE=
X-Gm-Gg: AYBFou3ZpH7MCxzDGzIbrU2k1dCjK8GrVcrRi7ZnqDvvvlcyGi3dO65GfXyjOCwdAo+
 kYTWp/Xg5KeDAOftpWpSM7ebtPoKbNh/ELf7/4gJcOQaBop88+msl+qpvgTB/y/duo5YiQhOSUc
 OYh4DHYaIf9tV/vuKYPklRDtwuOwTQhpinNQ1EkypY9GK6n4cMAyzexV96TLAVS6ziHwflgR4Mi
 9Z7nzHA+SX56U+594xsZlUj0Tv8azT1HvDzX3AZs+6kIrsba4d8Y6Ey1PtkW3O17qUhBz4VYR+1
 cEZhCAjnoNmJKxFPOx1IUhWV8gZc7Gd7TVLwzo4iVcjY0ytqhhF133nLKfdS2aEAJASvui98yCl
 ZVNlCUihNNn55cK+/dmBXV7hDtT2qkVifvlhk+iKhp8dKOUSUamoB4uQclh4u7svXTGhDjgJiSm
 WgJqrNEzct6iw/gVLoIpp7tMtlDQq9
X-Received: by 2002:a05:701b:4506:20b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-16a6081143cmr443229c88.28.1791510171189; 
 Thu, 08 Oct 2026 18:42:51 -0700 (PDT)
X-Received: by 2002:a05:701b:4506:20b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-16a6081143cmr443205c88.28.1791510170682; 
 Thu, 08 Oct 2026 18:42:50 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a567aef5sm1797833c88.19.2026.10.08.18.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 18:42:50 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 07:12:45 +0530
Subject: [PATCH RESEND] configs: qcom_defconfig: Enable EFI variable
 runtime storage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-efi-runtime-v1-1-6f02220d2020@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJRGyGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwNL3dS0TN2i0rySzNxU3STLNAPz5GQTC0tLYyWgjoIioGwF2LRopSD
 XYFc/F6XY2loAR0KsXmUAAAA=
X-Change-ID: 20261009-efi-runtime-b9f07cc48993
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791510167; l=1362;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=RnwoP4f1ulYcou/73R0+1MkIxOiuHMetTx6g8cAH8I8=;
 b=ietTuImT1Qtf3nLSzkWlyYKpP5/sa8Lsahk/mJTNtIXts1fhaN2mHCgDy6kg3tuhcLGpGJxnw
 BekToLUzj6MBL4ios/KC3SNDP8o6J3SRkW0OQp3q6K1ieT6n+3oL9BK
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfXxvb07o2UbRVo
 YM/Qm1sDMThHRCCzWpt/jAX2XbD6CW+uUL3gOFc4ZdyM6DieKjZjoEXZMArAZQ3CRuqhjx1ykPA
 rDoE0HvgW2np3AJ55KMFgGDtOZ8vCBxlckXcTy/t9LDXftdWE2be+vcsZEXZ8hmoQF+TaKt4sQZ
 ep6dSyo8oKl+KopI56d16fD9B8aFZqHrBIUHesM3oexVh1MShNVCQx1JRzXSx38r7hxZczM5glY
 nm1DsVClqkUNkNh+62cQDQMJd8CWZUBmtpdk/DIZCPakQDgzlU2kdN1iKQVp5cyhdPoPVqGV7FV
 mr4TxE9hZJg5z0Iy/dYVh/ofwcw1m1ge3b0GSeYfW0fWNoOMknPK9tOBsLeDYEqgqD2uQxYtMH9
 LVtYde9uxfHChHYEV77/oUQWPIyyIEg2tH+aGcoWOD8kxtp0jRQJK6cMuzyHOt2AR3o5vyF9P1c
 K/VBuqpLjoQWeIVdBEw==
X-Proofpoint-GUID: SdB8GwNpiuxK_FuSZlTfTUWKlFYhE7nK
X-Authority-Analysis: v=2.4 cv=H/dOUOYi c=1 sm=1 tr=0 ts=6ac8469b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Kie2jH7Q7-KxTuJzeT4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: SdB8GwNpiuxK_FuSZlTfTUWKlFYhE7nK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwNiBTYWx0ZWRfX9Llap8ZnSCZD
 HWWCpEvv44k7fJM6L9JJ96yFvG5HnfYG/NnunpdGbyXdnJG6cB06bWFr5ul23ddsPK+aE+Ee3On
 E1mzWSU152RsKvCpkvSP/6On1bPEQv8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090006
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

Allow SetVariable at runtime on U-Boot's in-RAM EFI variable
store so the OS can write EFI variables via efivarfs. With this
enabled U-Boot also advertises EFI_RT_SUPPORTED_SET_VARIABLE and
exposes the RTStorageVolatile and VarToFile variables, which
userspace tools such as efivar use to persist runtime changes
back to the ubootefi.var store on the ESP across reboots.

EFI_RT_VOLATILE_STORE depends on EFI_VARIABLE_FILE_STORE; select
it explicitly so the option is not silently dropped if that
default changes.

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 7d4a2b589aa..40ee45e8d42 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -10,6 +10,8 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
+CONFIG_EFI_VARIABLE_FILE_STORE=y
+CONFIG_EFI_RT_VOLATILE_STORE=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y

---
base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
change-id: 20261009-efi-runtime-b9f07cc48993

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

