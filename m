Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297F7CA5FB1
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EBF24085D;
	Wed, 30 Sep 2026 06:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gYhqHjTb2SzG; Wed, 30 Sep 2026 06:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8961E4084E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750110;
	b=YlaoGKGNxXWy6QdsxN++ZfsL8xNs7x24TH2pNh+rs9JlJzdHUHicBdRwMPGLIvnYT6vN
	 6GEsFX/GfKtUGeRgw4SSr5IP0NLEKjsZdzrDEranrNRr0hkfqXXQO80K7XHAgYMdpsEtN
	 VNhVHjHYj4QSK8NyhYO03Kttl1181iHH++cPmIw/71S8ykGxfdX3ZAm5e/W1YTLJbt2c/
	 xnCiYLYRYMHnWZxnBdIWKrrVMDSpwzUn/XgvGi+599rkk8S2AB6Lju4dt9MWAz7K7se7J
	 CkgRqNkgZMPb82AQNcmpsKy5L9AEeSreLG79LmWWB+FTM1bVadxQE6Uo91kMNIDB8rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
	b=dus8Uku0ocWRxLXGuUOFWoS8IsnyjJAA7Vc2Z5JUAGKW0buzen1BotKgAlXI3z7Va9eC
	 yDunqGfx3Ko0W0FJNzDBHAr0105p8SUipXqU2DjfPX8zqKiMLit+B5rRUTYLLjkhTTlG5
	 FipOvM3N958JGRsOOGlsT4VS3ULRSeT4YpX7ekFADplvpSSboM3+22TBCUeRZ553EYZaI
	 UOC5XC4G5OthLyb9q9qg/GB7wFgAQXevr7qiFXQeceBXVPLswcatfNn9N5mCkr0f1yTuL
	 8bJZmbDNXNAmnhQ253vX9VNGpCMcSrX4FfFBG9GHn4F5x/1H/pOIT4GrOvrAVZ3jECw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HztoKb7y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cDBaiUO0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750110;
	bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wjH7I3wefjCzrfpibDpgrfxMz6qiBXsObLlgK0tlM9/625V7fnF4JiS1xFl5NzdWJ
	 QNwtG7TxCWtNLMhCIrlGw5FYkFBfj4l1KkrizJtPcGjwNKcwkhn01/LNOuJcc5U7IV
	 4I2EPoknc0iZLYyMH+7Q6QxH4ahKNxXR/Icyn6DJ3DlzqFTTzoJ8kagFTCIu4355QR
	 sk3yzvrZZNCGaC0n56PgKqNBF2TI6NYqVuWrtwXUgDYTWvPtQSvKDN42MFEpgdlbbU
	 EZwmIjJSWswrKsUEYrXXfiihxBrgFFDbC52AIjix/JLxxjbqoiB+d1i94MIqllCKnN
	 GgX5DatUnigOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8961E4084E;
	Wed, 30 Sep 2026 06:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 46EB332F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CCA740844
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sZFlWy2nkSye for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EB7474083E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750106;
 b=SGrfk/few+MxA1VWPSMpfVbzWh7pC2Axih88oSi9dKxTtX6eB9VxBom75NzoTYPRe/+u
 UCCOjD4oMt1LQ5OXlVHVSsQXKEexxdeFAb1EJ+R1VC1YyOFsSNq1Hra6+I+tO0jXX9bVm
 0ZI1wE8aiQuMWemqij2kUV8IxtPD3e8yxJE7xysmHifxTXE/BiGiWiMmWI16mj77ruJ3J
 qep6d5yyos3ZBNBMM4WABFOvQJ+kzBGyqJKaNvJWeVn8sd4ro7H0hvomJ2l1UUyl/SkJi
 uPek+V0KxKbAJbgni3JnPPx2rlkzPIkuYvojEcMyaYOCIJDsdOvfuTpSa2d9cLCTvKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750106;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
 b=OC625qU+5PVLhrEylkUM21qribC9Q4DVQB41/kb+Zt5/7soyqMYa6dXKAOjELc7j/A7j
 VbIT8BM0PsFkJ/QPQJzyCF3RNj4MuRk6KTKb41Yb/VjprgUbB0PG+JpUWpUiqo1/hw8/U
 hHZksHzSW35gyB4w9425cy7YcLSTluA1TE6E1ihhbzHqZx66B/AV8QlPWjyosX+PQ+LFd
 Hj4pL9RBqDtwGRHpgGJyRCCUuDwsT5Nlu0IIVrOQgyIF1HK+Ns9gJ/OOZTfw/Tu2fktdy
 SmglvSKFxIlLeIUldBCeJFSpmRyclMlhi/Ap0k1E+vSRJ9i7Epx6fZe299c0oO7ZFpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HztoKb7y; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cDBaiUO0; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HztoKb7y; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cDBaiUO0
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB7474083E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:05 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6ACsv484456
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QnaVAfsfJOm
 maWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=; b=HztoKb7yqiWRXd3MyeGdySgkhXJ
 arpIEehC4wPm9LuyHAeIIVeCZtq7lY0UHF+Okty60klWtnJbLy6Cct21o2T8tfeN
 TtUlpxPUXeSYRaF41PzZmU0KV/3HCG9TKE81mVzhZXPeDdT2tXVyiE0JWWKd4ah1
 I0FoL8sAZsEgCFhagy6Hb+cbkmWUau5WsEmcFrkMTV1eIaEkVkY0cP87dNf5dDgs
 HD0Ty30jNCCRPjGX6dqmBbjlaRU4mnsRTWX494wzhvWJgNn0we8NGa0bontZRCG0
 /OoT6EjgiWHEpiz+86UL8qlNJmqLn+InOprwTiL0eovwSuxR1oUGzJxjxtQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0dsx45wy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:04 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1416f32fe11so3904498c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750104; x=1791354904;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
 b=cDBaiUO0bBofyloSWup3WpNSczqR5KdBwcr3ATVSCrR8SwSOxKIZEQuN37cqymbtjM
 gTqqaBneEfzaLrr0RGYZ3Vshyporve2gGnOKdVs5XJsY36zuaaA4GIYgbChZ41joDNRM
 gXJW+gBVVTzNhQ/B4DYyFXkzl6Wn3195aPyhsCIXEFSg8UjjdyuuQuOJEe4RpQFFBKc7
 VliCgp334b9GHP18FXYT6vJkHf2xyJpX2tZTIgDmbmhHEjjj0dGLMZVcsR6EDWtTPma1
 31VLK0bS/BiSGbNFdd0CE6m7JT37CFdiU5O3vqxJzyIRcKGPAcaC43BlsHkO0/pKCGqU
 m/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750104; x=1791354904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QnaVAfsfJOmmaWMHYNe+vnpymJXGvzCk65DwaMtx+Gs=;
 b=MzUrVbKnLUi60DZmmY6xFw2BCSoNYNUgvqMemNluVpcdanGZIWa3HIG7QerxOa4Orv
 W9unR1UZ9N78DxUX4QZZbLddYEFzB8IawlXzhOUy3ThtcyRl/A414RM7JMYV8hj7Te3s
 WbP9m/pIhVo8MUEdShWF6yjR1QVO2UvkZAJp79L8+dBlWyoHHVCAoOQMSTR1cXA8km8Q
 PRkN8YSGoVhLRbz5BgeOONGm5297+jZA42k7q6SH8THpH0FZCMNj9DtUKz9FWaRc6cI4
 duTnZUJ9b8nIZ2YBl13kG+QXF8PIIkkgijL7wmVRtnWhjALE5AcspPbp0UfEPV2kPQTa
 cObg==
X-Forwarded-Encrypted: i=1;
 AKwUvByR/M/PwTjQZo96glbAo9gNuWN/Axm/9YFAxs7VvVNcvhyRCbWKyn9W+IbICVb0iQH0gE1MSRQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mCloql52VM+gjbK6g1z/kXrTr17+Orali1yhlFrJ0xGXf550D2
 bMORvioLB5xwj7gN/OI458/p9vCpAMKpw54P4CBoYmD/C6LKAYJKxDE9UgDX/761UwtiBvhFGGe
 ADLwswd/kdkdXY1x813szHMU31XO/9fMObTlqxGknPbIQt2w0452+XGLcFQ8w8sasfQC+rfA=
X-Gm-Gg: AYBFou1YxS5nKmARsVdSoW2EoqzY9sKkA1G2wTsdYY1o54c0sdjJlYB9O2LiGLXKq4T
 UbUmRZtf9audUKnsX6T3O0H7yG4TRVw3uPmIypsYth84BHCmbrDRe1yUKK47S7EuQljAL/soIfL
 QvxzU3lh2h4Ham4yoxMP7pOKpdo79YNpk7YixmJg+1NBZkvSmveeDYR5hc/ajMuQL8klRq34OfN
 ZK5vSv9YOrKwRQhGRMeI2KgZcATSxksQJarny3wkDYdiU3/Ql/MueBKLVO3aAUpZMkFL3VcYoG8
 rhcXK1vWc1WCWliF6Ca9jSA1TTSlpGFL3tiQOzp3g4Tes7Zcpo09VcEdhCH7wngXNcLpSkBfnOt
 lx+YKSR9qR3kU3MIqisWcSfKmQbEXtGMKGG/ovY8wc05ksJTT
X-Received: by 2002:a05:7023:a46:b0:148:8aa2:9257 with SMTP id
 a92af1059eb24-14d33782069mr231404c88.34.1790750104212; 
 Tue, 29 Sep 2026 23:35:04 -0700 (PDT)
X-Received: by 2002:a05:7023:a46:b0:148:8aa2:9257 with SMTP id
 a92af1059eb24-14d33782069mr231375c88.34.1790750103698; 
 Tue, 29 Sep 2026 23:35:03 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:03 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 02/12] pinctrl: qcom: add Shikra SPL pinctrl option
Date: Tue, 29 Sep 2026 23:34:39 -0700
Message-Id: <20260930063449.3251317-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXwr6GgVTSoX13
 c41fXJa2ZjOcep0KRwEXILdKrmQj610IXp4AIJKqFjZmLkBT0a4e5xDFfo59z7RLrNTnrT42eMe
 PSkapGLEwQhVjhAssCM6XkVNNb8Ee/DOVq6E16R+hlRyAfEj/woSH18C9wxrzV0BW8NIFvB1Y6h
 VNioI2mBd1WJJKJ43zlS3TGtLp+LpJ9DuI5HmVW0wAXYEpGZDvsMK01VUGypNgtp9/UeyKz+li9
 7q8EcVsDecmcBnzNJJzhfZjhiPs/YmorAhahgbUVtdXst5hwKzwatNiQzISIGWCS80XxvCH9DTd
 WT0N8ykyjI45KJbOZRxegDr5Mv5C3jZFgWaFpe4IpGDys2n1bae6WtakreroMHMpI3Ob+jNol3N
 L/kMEopxtwSJnrj4HoZ9ZyRVhKkeGcqJdRdKHQZF30EL3eFgYJ2WiIz7zDDlWISIyV2M/dYtYU1
 AIqvrdP3cTcAyHeEnuQ==
X-Proofpoint-ORIG-GUID: 5KmEX19ZciVZsbL8Q2X6euaKrRgG_y08
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX+aJDGtYapVNv
 C9p40q1GO+iD9AxISQVMRqlWx4xPZDDUqLhJ2DCt9oShXqmZZrQXT06Dte4dKoqIHfrd9Wci50u
 FVO1wbquj8yVGdidSDJu4GIgOZqHFxg=
X-Proofpoint-GUID: 5KmEX19ZciVZsbL8Q2X6euaKrRgG_y08
X-Authority-Analysis: v=2.4 cv=DqvDa2/+ c=1 sm=1 tr=0 ts=6abcad98 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=w3U0zNvCpQhp3vIinEQA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026
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

Add the SPL Kconfig variant for the Shikra pinctrl driver so
SPL can configure eMMC and console pins during early boot.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index ba866b5b6b2..0317489a3da 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -235,6 +235,14 @@ config PINCTRL_QCOM_SHIKRA
 	  Say Y here to enable support for pinctrl on the Snapdragon Shikra SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SHIKRA.
+	  See the help of PINCTRL_QCOM_SHIKRA for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
@@ -421,4 +429,3 @@ config SPL_PINCTRL_QCOM_X1E80100
 endmenu
 
 endif
-
-- 
2.34.1

