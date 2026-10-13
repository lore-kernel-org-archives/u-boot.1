Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1078ACC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B312405D6;
	Tue, 13 Oct 2026 05:33:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v1j9u5ICWygy; Tue, 13 Oct 2026 05:32:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0884D405A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869579;
	b=oCac21Ij0SIP4tIvzSk4FaXIne6iJMnuEB8kZcMnK8XXQ5RoCO3NuqAwK6EIH9u9yXpM
	 Sh/yGub8BskSMNMvg3ouz1hhx+8AGnwDZOSunUYDX8e5DMtOBTmISRA5o15WlsbCw+Uv1
	 FpqmTwJswkxsqSzCJpEB4g7ehIvxc6KFea7tKAt1550Eum6ULO3z36oQZQWhrZNh2cnjg
	 P2nkL2xSUlTMpWxlLIN25ml7fPKpJYfPPiGDeJAKNL2ORoOYWmpGaHXY3/w+E3j7jnvho
	 sECc3x8eFpHqIV0s/fKsN+QBGOG7NZ5CC07NYKkIPM74fa9cgCc/Bo7leRCsby8y8RA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869579;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=srvfPm7A/UMIV0ATgc7ErmiTEiyzfPc7J8FOq3Poi1Y=;
	b=sjeopjBis690Owu3DqMw9GEV53EzDdmtkhfIHdzfXh0uBaTqxWlMrvHjBMYhSRZq2sUA
	 bo6+IC+SiNVTceGY+smTvk5PkwT8NC4hRd7vbZ8gaLOVRoxlWTAe0mmwmK3+fD5s9DZaW
	 mUGNja9Mau+jve45TClrBgqYHNVH+hq0U6wdIdLFVp5XVO209Uj+OwFagQMsv0bE440EA
	 zdYd0UghWkhGbXTmLw3xswcwezyZd7aNtDaJ0xAyxoKDKtdtowpMcj8mQElTTYEtR9GnS
	 Hxbw9OqskC7ym4eSFBwoVL8f48+hGRLmqEAQ5etrG3kDHL+DdATm4roiBryDfRF39lA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PX36HrRW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gMq9uOFb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869579;
	bh=srvfPm7A/UMIV0ATgc7ErmiTEiyzfPc7J8FOq3Poi1Y=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H1ay94j3Yoy3KmsBYFo2BTvIDcKkX/5gDJkBtdVjHMMi//bZWsg8RbKohwGjChi9Z
	 QBmZVV85Kio+EvN5qh3+8TQutUat+6YoXyjJhme+a5Uqb1UBRMpAYAkBbAiY+PhyhK
	 oX6956yzkdykUZO7kMlx+J8Z4kNfk6uGTkrcQQN9k/urQpPc+3aBEx/R06s7N6pLzq
	 Mawa+XgpXdRRXTDmKk3WlXSSHZ5PNk9kR8VWDG7HcwRYhixUIIVfu+DjpxX1qfSSsY
	 1gagYhbhyCTIZMB5L0MgWOiLFlXKhZhGuCwdA8Mf7iBacrUH/S0QOYXJA9oPTv9IC2
	 gAJ2DdRdE6Iag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0884D405A3;
	Tue, 13 Oct 2026 05:32:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F621105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 81272405A3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Phy3pYqBOnoc for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7751E405A2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869576;
 b=kjOV2KifNqxPhGXuiccKtFmgyXUu/kxQVxBrz+v3ehLwt0I9FjZKPXcgA/dDz1i3V/kC
 RiUtzBlvzLy8KSsZ8ue15hEwpg7Aptytj+3W+vWVN/urKlqHGkCnwf2/2A0GG59IgDAk4
 j4I9iqOGGolXkOFpWz0d1beAVbO0oYamDUz3meyrVN9ejnWQjttAOIGaAufHoa+Lwk+IG
 LUne2Tg6aBORSGg8+ZusSa+Wo61lu7CA/Mb+277UOZigxNCWtCLsFZe3sPrNAqXmdTUs9
 8qKFKqTNnQuTiEQSBZii/VPqq83XsacaurXLz2ixBX1xdThPPR9Vou4Ty/ykqjZn4nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869576;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=srvfPm7A/UMIV0ATgc7ErmiTEiyzfPc7J8FOq3Poi1Y=;
 b=AJGoJ1aeFt7bfkkz3sTMPigygvk/fxFYXrq0VMkgVjT1RiklT7ahpd9BVilUQRr+8nEV
 bi0SrQqCQs1VkZUBELV8uPZ5mm1p58RuVKNxatLCGI5ObA3aE339LOwWTONWGlp6IFKig
 t9ixq/ixvUaRThZzqb3UZzSE9EET+LY3rGscGM3iKgvAu11Tmzf7P0Zn1s71ciVHjtwC8
 zLbXXI3UqYuFej81CjQyu89IZXenXgwFgfiEMQ25JUT2GKmjLUCwMEdR1acMimRMjBa6s
 a5eJGjlOVY5h7KbWDS1N4VPIJJuZiPHM4IK3E6blhej4f3rZKlkHt9KE3AII6hTPybg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=PX36HrRW; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gMq9uOFb; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=PX36HrRW; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gMq9uOFb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7751E405A2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20mTM988768
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=srvfPm7A/UMIV0ATgc7ErmiTEiyzfPc7J8F
 Oq3Poi1Y=; b=PX36HrRWgBg0FFw8Y4qr5Cqn0xBP7/Fb8x4/fNTdxRwaCSt2GSr
 ol+a95PesdLXT88HXRDIJSS/Uwnn0DhxEDGsMqkzBW/RZlepir0w+Hq9G9VXfEca
 9KM9TX8Y+XbaTTVzrn4O1SfkAeqRRhMtScyLSmTb46LgZi5cd34jo9GxC5S3mNIb
 f2R/Sq0+g6KqCT9po0iU4IZnx7SEuK1QXrJ8m7vEuy+oO6KoseP1ksYjbtpOaOiP
 XIAeGkZop68ZQEka2PMlxkZ6PZqEjxSFRElSjbiZedQGCeqjmpu6eiKFvCd2ZaBS
 F+hpHF75dTb28HBJ/46Qln7sFVQSaY5uQ3A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hc97xk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:32:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so7358513eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869574; x=1792474374;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=srvfPm7A/UMIV0ATgc7ErmiTEiyzfPc7J8FOq3Poi1Y=;
 b=gMq9uOFbJCBU6e8e5J7L5XeM5tH7jkDiNvLapKmIdAccZR3jPWnd1jxgtS+mvp91If
 4NO51QEYPErW+j0RfBsfFI1kMtNopFQ2Hi1BCvFahFFPUqAktL+FyfLarVI3Y7WJDbxe
 hZZPXbTVmcwVFHXIzy8CQ72L9lWbYn6VmEECDijvTxj7JxkDBVmsQA6wy0tWgQbh7WIU
 NfPMPmyjthR8rhU8CVx4wFfadho+Yq44466rBkjDxeUTjKcgdaNBt4AebuzO1jZxiulz
 3+mloWNBfmSvm/B0ThUDvoDorZAk9OzU0fuCYXxjIZkuuzzDzFas/ddDOeSBqokhY/ed
 XSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869574; x=1792474374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=srvfPm7A/UMIV0ATgc7ErmiTEiyzfPc7J8FOq3Poi1Y=;
 b=xXTPp4oMTyHmzM8fWDx9cXoANwaqcx2d9XGEk93e6cULGpRto/hnLmI12Cw3y69HGG
 O8GM60W+a/znGl+G79ZvD/RH59LdEMlIcV+unC15BdbONzL5Sf3Nlj3611LxZE3Lj/Ok
 YmJ8QXwFV3gV0cPtOFbdi9PZ0dGygUmiU217ZZ68yyO+t+Q28LwgU7H3xIEpKnKHFODJ
 PR6hJxiIs/EdV6ZHdb0gqbEEywSl4lP7tB+vmLzGCp2622BFOkM58VGo8wfat7iw9EmV
 UD0rKQjC9wDJaVy3VI0gUZycc6gzHcU7WeZ9ZxjvD/gJgZz4yH7yMK5bMNhj2rummwKK
 TQzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzO6ZcbJPZTVjbmM83FO/8k2NzZ4wrbwBegh73Qa9vwbb/PPGFWSC3+PF/aDLmD8ozMTAk2pb8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLMiSWcZpb07MT8Cxb2hLMqZdXCOlR8VYaSIjsNTf3i4CplipSy
 +nBXbJvJOBJJDw1f3yQtnhmDEFj5A/ZXpJACeEjTbbmjCArr1+8byLzocJbrN/vli00iFX4G0fm
 kzXjG4hYh03dq5j0pPieGlHPneqQbphR83XdEOgbQuAVhPoXegpmw9NHs+QQ8Uy9/cnHTca8=
X-Gm-Gg: AYBFou2mWqrKFTK6BLWJwbRcy4xYrL8SFdPK38Arch7hXmvt74NrrFZjXvFBK+6IJ/O
 3p/GGVH9zy9fCip7sX97NK2+9tjZIUoTMdawzAXHKMk3yYb6/6JrLxwE2iNWXptF3XPQR98idAt
 VnuL9Y5QdWBJAVrTqPWXQ8EYfc1V2BjbAhMyinh8ldIbvnSY+7N+e1ekKXfprbS58vqAJmL+FTA
 wF19btDU0IjzPaUtHfFo9WJfJtxhZWnMOf+CbOgZDRAwF6fgh+qsW3LI/WcpmEybuVPHVCMwjYp
 XabUPPL1Nbcy+IDUKz+amE9nAxbvShvPXZrmL0/lholLEk8syKa9EALyKRk5ezi0votHhFblsFn
 q93awnvjwXjC4ML/ooB661Q70ca8TwY6K0c9ikvYa+1UvfTc=
X-Received: by 2002:a05:7300:4706:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-3537e021d3cmr16643808eec.18.1791869574142; 
 Mon, 12 Oct 2026 22:32:54 -0700 (PDT)
X-Received: by 2002:a05:7300:4706:b0:34e:3ce1:39f8 with SMTP id
 5a478bee46e88-3537e021d3cmr16643741eec.18.1791869573341; 
 Mon, 12 Oct 2026 22:32:53 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:32:53 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 00/13] qcom: shikra: add eMMC SPL boot support
Date: Mon, 12 Oct 2026 22:32:31 -0700
Message-Id: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX3o8c5/RfKgID
 2jRMzfkHmIZAI2mtGG5uKLPBnYCOU2gxY5COjo1ulEYdzVq6jO5nDBqNydkMUZIOzdZ90zt4aKI
 U1QCw+IyO+oSY8LqmQyFBtFawKTTnZCtNKJpu54SdaCcpQgOcAUA9HDFgqSEnmieEgsQ78D1pKz
 pPYO6QoblZnAosVXZu07hAtqfkYaXI2A0zn7joA/XUz96PdMge2SGO7ES0xE1TcQGqEV8g+ABcP
 2dqNpQO/xDcxP6kMvZOemsHlAi/LiVtdg89Yr4oAjFzoZkRvGn8JI/Y5esYv/YuOPEGpuOEbQ7v
 2aFjQRhrEXWnwDn4kJQ8fwAZn+9/Xqph+P1GCnx2vS/wl41a3c/AHsosukspr+d3oIR1sGgWDB8
 IXRKlWwxjbt19TNZ+rxlP/tyBUkG/iZinhVKxCnin8VPKRXyDA5pCQzGxgx2XJJE+RfMv5VvTkX
 qssyLjnusm3x6h/NuaA==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6acdc287 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=ATsbyuJYeBj__F-aJUoA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-ORIG-GUID: wsCQL0_qbD9xuJMwM2VJ5aFvW5-jt97E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX6x+lLQrpGfkg
 TZMbGRTyUEWvgDOyqIXGsgpLlda/9gdZxCCLRVG34YYpgoLx3NZTl9Epp3OTuGtMip3Or0Cd2Cp
 rk6+GsZwLSO8Rc6ctPl5uDmAaEnwWRs=
X-Proofpoint-GUID: wsCQL0_qbD9xuJMwM2VJ5aFvW5-jt97E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

This series adds U-Boot SPL support for the Qualcomm Shikra platform.

The SPL runs from BOOT_IMEM and performs the early initialization
needed to boot U-Boot from eMMC. It configures the required pinctrl
and clock state, loads QUP firmware from its GPT partition, invokes
QCLIB to initialize DDR, and loads the U-Boot FIT from the eMMC
boot partition.

Dependencies:
 
  This series is based on the following previously posted series:
 
  - Qualcomm IPQ5210 SoC bringup v10, Varadarajan Narayanan (15 patches):
https://lore.kernel.org/u-boot/20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com/
 
  - Initial Shikra SoC support v3, Aswin Murugan (13 patches):
https://marc.info/?l=u-boot&m=178668446732727&w=2
 
  - Enable HS200/HS400 eMMC modes on Qualcomm v2, Aswin Murugan (3 patches):
https://lore.kernel.org/u-boot/20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com/
 
Changes in v2:
- Added SPL MMC boot-source selection fixes.
- Added a common Qualcomm SPL helper to resolve the boot block device.

Abhilash V (11):
  arm: qcom: add common QCLIB SPL extension helpers
  pinctrl: qcom: add Shikra SPL pinctrl option
  board: qualcomm: shikra: add SPL board support
  clk: qcom: add configurable FSM-voted PLL helper
  arm: dts: shikra: retain QUP SPL dependencies
  clk: qcom: configure Shikra GPLL6 for SDCC1
  clk: qcom: enable Shikra QUP wrapper clocks
  mmc: msm_sdhci: make tuning callbacks optional
  arm: qcom: enable MMU and cache setup for Shikra SPL
  board: qualcomm: shikra: prepare QUP firmware in SPL
  board: qualcomm: shikra: embed XBL-sec in SPL ELF

Aswin Murugan (2):
  arm: dts: shikra: retain SPL dependencies in IQS overlay
  clk: qcom: build only selected clock drivers in SPL

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  44 ++
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi       |  42 ++
 arch/arm/mach-snapdragon/Kconfig              |  10 +
 arch/arm/mach-snapdragon/board_spl.c          |  54 +-
 arch/arm/mach-snapdragon/include/mach/qclib.h |  16 +-
 arch/arm/mach-snapdragon/include/mach/spl.h   |   3 +
 arch/arm/mach-snapdragon/mem_map.c            |  22 +-
 arch/arm/mach-snapdragon/qclib.c              |  77 ++-
 arch/arm/mach-snapdragon/qcom-priv.h          |   4 +
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/config.mk               |  24 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  40 ++
 board/qualcomm/shikra/spl-shikra.c            | 479 ++++++++++++++++++
 drivers/clk/qcom/Kconfig                      | 208 ++++++++
 drivers/clk/qcom/Makefile                     |  48 +-
 drivers/clk/qcom/clock-qcom.c                 |  48 ++
 drivers/clk/qcom/clock-qcom.h                 |  24 +
 drivers/clk/qcom/clock-shikra.c               |  73 ++-
 drivers/mmc/msm_sdhci.c                       |   4 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 include/configs/shikra.h                      |  11 +
 21 files changed, 1190 insertions(+), 52 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/config.mk
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

-- 
2.34.1

