Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A55FCA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCE4840942;
	Fri,  9 Oct 2026 18:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5X8o1sRxeRO; Fri,  9 Oct 2026 18:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 201C040902
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569616;
	b=fXrOn6aT9KrNmHmEpaWuwiDbpjAc/2QtcRK3SNAz6ji+lMo3mBiskW3O+JXdYgRFSF5b
	 2+i1lyXRQj4DeAEF0psi37OiIA9GRpY9wII5I8HoWqTNuDx53LclE+2e3uBMQeYSFtDVV
	 9QTNH8zu8pKuBhiob+Yz0X0M0LDMqubmUr0L86kKzbZlFy+CJOlv9al+xQ8/5d6Crwcuv
	 1K7UGQzPtYjoP+G2oUh6xlUj28yqv/D/mQP1jZJT0/Jq1YAF8aDKlZ0Uk0SXuiixWHfN/
	 Iyx5TCQIAelW7w1OmNzWf0DyPWmgWVUBRIhPlN0jjLjz6nP6b83rsTJf+uyvfIo3B4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569616;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=40tx1vZEguZMKVopz3ITm8tIuAdzbtt1kyHQDj+ZvCs=;
	b=mjxFsXmJIaetO3stPFtTAw+3VA4czWk0mtO0+zIPQkCnjBz9o9ZZVQOdCYT7xkB7E9II
	 hM1/6LK5FGGuVihu04y7FhDOEJYmFwBlhrIjA8UJNlZMnFBNhQpKqjdiXP5oCfiRk49Sr
	 EYmN+RCzjYU21NuQT9x967YR0/aWD3svI4TOCzuuVdwTb5liopTD1HWd1LjZ2wposTAi3
	 udlheGnEz0r6z9JwjLK+xMiHvg8mF488uKvMrjRsrwWflGRomDbc5eD1F9aJtOX51HCiL
	 ScTkYfUw2UXtPh6o1JGUIV8HoKHJt23U9Z8oL9PUdhn1J2IUuqjHi0y687V9ZLNvR1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569616;
	bh=40tx1vZEguZMKVopz3ITm8tIuAdzbtt1kyHQDj+ZvCs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nWZ2dGJV5ZFTTEY/C2Z+E8uvB+MX5xdqmsHrvrOKGNRc3p22zBkm3Aqfqnx8Hnvk4
	 AbFghn8BKpeCK1pOEwmiJnHqrjclypek6A7uTLNbyHD/33aDjgFTi04WHh+m5A75HT
	 5LdZq7boCQBkKGGggMDhETD7j5WIfi1Z3LUOOrO2tYGEv4M19fSfIskfi6tUkMNMF9
	 ma2eB1vOP3Pz4LdtfBVPpsZaFHwifcA9cIFVq6Dq4r39pyvorEWGwZgflxQ6tRD5Fl
	 Fdki0y6O9LduRJ6fJ125knSV4rqkhXLJvhas6VMlIGxp8ghyAEHSjNWPi/wU+uphqa
	 czlq1DOHSpeiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 201C040902;
	Fri,  9 Oct 2026 18:13:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6298375
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F99F8129C
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlQs6_5vX3QO for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 18:13:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2802A81299
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791569613;
 b=bWP0mx6r43849rnU5IiVYJFJgbzWA+P6AxXWsRkv/Xz8LXvez0FAsmFeGYtsAT8eI6Fw
 0AgzU6//S/97j7v2WuFJj/Kse5KIzSnf/+EN8mknZivIZhDSfrtmkJJuoeZ0tuf8k4nby
 5ay/mJGKBafi8nrXtR6E97PkLJpIIIBScotTNKkGmK/YgR3oGS4ow7V38yslCQ08IPp+0
 t1jz2UqhPBB0k7Gv+eNpAvM8EsgyJPwxfPc0F33LQKqlqhmIMdUExuLWYfW+jAbjtHNOX
 KJ9IgNGl7/xBJUQDGM2Goywcs841XjcFw4Ktr9pKIYiVmGI6nltgsT7Z33RGURtcoBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791569613;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=40tx1vZEguZMKVopz3ITm8tIuAdzbtt1kyHQDj+ZvCs=;
 b=MzUJGIEy+ldBVufqeUCgQtBcDLA8sxTNuftQcKOBHE7e/2U8k7EbXSB9pbUMJquPatPI
 NQBavDsgX7nIpWW9KEeO5UAciUl9JwKahoG+4WtxvQKX7GtLEvD4Rg6NXs6Cs3eTiHILX
 QcRtrOYo7XGbssKJLRZeCsRYedzWJZi/jtMggK8JPgY6Bvfa1IXtjPTsKqULwFM7RpyPA
 0h0FBwPNrPb4rD5xj76+WuXcovRyc1yCudbIl7SpN2pKOqWzlHevo3uZ+lJidagkDrvTc
 q0/WpHopt+ZJ5EP81OkCd/acaTba2hsP8MR/RO7DQJ23bBT1Q/Keh+/hanUkq+PrS/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=RKVVgDNz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JaligidX; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RKVVgDNz; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JaligidX
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2802A81299
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 18:13:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HZgbg2470935
 for <u-boot@lists.u-boot-project.org>; Fri, 9 Oct 2026 18:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=40tx1vZEguZMKVopz3ITm8
 tIuAdzbtt1kyHQDj+ZvCs=; b=RKVVgDNzZMOLj/xoNAlVeVeWZet4ruQOR/2chj
 xH4I0j3tBvh0Au75p9k70rM3W+2LFkhsMYf3AghYSZaadszC9IamakObNqIopbIT
 VpI856IK6Ni0IEAw3RA8kwuf2950evQW63PoMYcFCRWx3zSttg7SEleYCvpIH4OF
 Y0t+OvBjwMpQPCMDkj6KF+LuWKLo3TLHiSXkF2DEOyusHVJiiRxnx3dG9QXESTgI
 r7Xz6Cfbpv4kJK2MDjR/JmTRT12nXfjsIHu4zKc2gT6zwGMuhhwEW6LkWpKDhdH9
 8eN4kbuElTdyblMyg2wQqX/eZVkc1KfANvrpORKDL8KnUi/g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74t8g4se-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 18:13:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e5d759038aso30664805ad.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791569611; x=1792174411;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=40tx1vZEguZMKVopz3ITm8tIuAdzbtt1kyHQDj+ZvCs=;
 b=JaligidX7kJJ1TpL0v+1QDNAyqvd8/0YeqNNFVj5BYx0h6vVIvHEHph8hkYq3xnaWD
 BBECxmRHVJkcva86Z39Fvm6nVht2TRNRRqLWvgX4U+IcNPTOIStHlQcYCSdSAPi28mXB
 LcRIgpfYW8buG97txC2UX+YPBtWRRmaPxd9/dLHsHaWGbQ0i0Dw8m1iHA+Oj2Iug9ra0
 B7SdDouB8kRL4Gqu7ZYzVQqPY2kpTVplM52sd5mMWXL0C26BGb5g7NUa1+dWxpP49SJn
 yY92xk+NlGuLTe1avP+s14s5rKdurBFNVXnPsXoMbTDudDyu+7pbTeLruNO8jYICDzJS
 WxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791569611; x=1792174411;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=40tx1vZEguZMKVopz3ITm8tIuAdzbtt1kyHQDj+ZvCs=;
 b=WlpeNqQSQXb3i8D46JEXWaFo/1KIsovuu8SiAQ0T9ahwiPdjwJdMOGvV2AYpzHhvf0
 FL0jfUSHxNO4rIHj6yS9L85ZG38KJJx8lkcRhh1H28ffpyIoyogq9gUF8fxfOZ+5W83F
 GT311FC0UgUP/skMPczbBqGIo+8C818pvYttXorZMaCSQjPJ/IiJCqKNw0UTAwrtRo5+
 xJWBngbpvkhqNpRClpYJYHw2TCQpLRbdZkJLh3QM7tjrF8wbfY9xMb5IHoFF7SsdYPxs
 D93CiEaq6k5NeAVgcSZ4Uaq4TOv914/sbzor8CkF1+f/GK5Ub7+Wy0l88GS80pNaQPt4
 eT5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC96Ig+QLQjdpEPxcAoplzJRlooJ3tLSvkigjo8Uc04D7dKc3ZGJ9hU4ddnLPe50BLV4EQQIE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIEsssE7cO1JcvcZZpjNcNOIBlwMugi1Jfbgp1sR/NedzqC4kJP
 WA1W18qBhel9+ppT2FmDmB3i8NHGTy3At8eg+PRKTJ53+gq/JwXGrkN8aixtoFk0AMmaUjdSkdm
 o6aT/dlbsalpZeNjMjKHp93JgNG4giMIaVwO3kdaAq3ETq8WPAaYtkXaGOjuG/Wb1qi/DHLv1LC
 h0kXI=
X-Gm-Gg: AYBFou2VobJSTiQTEQoH01JCB1xVdeBQnhdoiMIwJfibRClutp8VHfsxi5vrn3yzMXm
 n00jC3BRi5B69MXyM2udQbuckMhe0AtK40fSiAqeInQGpTfAnxKBNVEzmExbf92GETCQdDbpFvU
 Yvl1BT89YZQBoXTYlcJLSQzdoJjK3vbVFiwZ/3idn7J3HpwEN2/Yvwng8SmOQXCmdkIsolls03E
 1jt/v8jla2/P5EFwukHc7KXsRvSG8suja/nQDiz0NYfQdbdGdL4flu6H5pHAfniUmt+7djmcO0v
 uByujIbfTJIoIEhSrQmrwMr7Z3kc02DfR6/kN3kn61DhRBmQlYY2cHbyxlYgkSodoSF9NfcuMBA
 xiSVDroyc/ClSCydZLqlTGKZvlnp6B5v2bdXzx3fXjfupp8y6peqPV1pWbdtAG/pbA0bB7Qkb9P
 pTlCgQjVuyAj5ptDRfHA==
X-Received: by 2002:a17:903:3885:b0:2e7:c818:a091 with SMTP id
 d9443c01a7336-2e842e0cbc5mr26349625ad.57.1791569611365; 
 Fri, 09 Oct 2026 11:13:31 -0700 (PDT)
X-Received: by 2002:a17:903:3885:b0:2e7:c818:a091 with SMTP id
 d9443c01a7336-2e842e0cbc5mr26349305ad.57.1791569610322; 
 Fri, 09 Oct 2026 11:13:30 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422e2aa4sm14599845ad.71.2026.10.09.11.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 11:13:29 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: sjg@chromium.org, trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, seanga2@gmail.com,
 alchark@flipper.net, lucienzx159@gmail.com, daniel@makrotopia.org,
 michal.simek@amd.com, aswin.murugan@oss.qualcomm.com,
 nathbappai@gmail.com, Michael.Srba@seznam.cz, jbx6244@gmail.com,
 marcello.bauer@9elements.com, anshuld@ti.com,
 tan.siewert@9elements.com, james.hilliard1@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 0/7] qcom: Add NVMEM bitfield support and reboot‑mode integration
Date: Fri,  9 Oct 2026 23:42:45 +0530
Message-Id: <20261009181252.2334254-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ONOyTiaB c=1 sm=1 tr=0 ts=6ac92ecc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4I-owfGHyUgqjhYrcLAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 3ytxHvQBQME-b_Yx4OhMeU9ETgJkWSLD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX3aBc2ZuLBjlw
 ws3OYojh2gHhqZCMxOHU5O5DM3l46Dwr9doP6Ks38MvpcH9o1MOYyR17d2Ud+5ih1bAVpEc+A5s
 nUkSNHMlml2UxjSeAXKdSMbTBlk0xBo=
X-Proofpoint-ORIG-GUID: 3ytxHvQBQME-b_Yx4OhMeU9ETgJkWSLD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX5yGi2wu4cBPE
 4C2l9BMrBZS4pJFcRMtor1YNPeJm52Mmtf5h+RRFuDr7MZVmqNJl2uZDXkgtaC/OwDhGN4Lck43
 EJCUw4tHi/uM2mP1tMgQVRZxEVxrY5IupOxcJeyYQgZmxsuoL+H6jVz7eJZ/OYNbCAmANN1da+e
 RV79Ub0mq9ZRops3gDudGcqUO2QV37jQGe6kN4+JycSOKtZML0kR3ck/OscPArgDdh0yFBOVMBh
 v5CwvXFBbBDU6l/swy+5oP1oso1pFg8GT/xOHeYP0WXj1t+E2uhbtYeAHaASMyv77VatD3JwqMO
 S9D0zHQdtAprjqyo0MVzfzHxqueCtpLloFhw0ONSQ8MvAO5YlRph/r3cra0ty7qTlt0IOxoBNKn
 NiyHbyutU5SFfwyeZljKqxDOzarB9Mo+KUBDOex86IDvLhEaizwaYeRgABxm5k0T8/IYioH/4/5
 JJwzjn886fjxQz0S+6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090072
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

This patch series introduces bit-level granularity to NVMEM cells and
adds complete reboot-mode support for Qualcomm platforms that store
reboot reasons in PMIC registers.

Qualcomm SoCs rely on PMIC-backed reboot reason storage to implement
features like "reboot bootloader" for entering fastboot mode. However,
these PMIC registers often pack multiple fields into a single byte,
requiring fine-grained bit access that the current NVMEM subsystem does
not support.

This version adds automated reboot‑mode environment updates via the
REBOOT_MODE_ENV_UPDATE option, ensuring the reboot-mode variable is
set during last-stage initialization once the environment is ready.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

---
Changes in v5:
1. Added REBOOT_MODE_ENV_UPDATE option to automatically update the reboot-mode
   environment variable during last-stage initialization.

2. Registers an EVT_LAST_STAGE_INIT handler to probe the reboot-mode device and
   trigger the update once the environment is ready.

Link to v4: https://lore.kernel.org/u-boot/20260408121841.186410-1-aswin.murugan@oss.qualcomm.com/

Changes in v4:
1. NVMEM Core (drivers/misc/nvmem.c, include/nvmem.h):

- Explicitly interpret hardware bytes as little-endian for bitfield operations
  to ensure consistent behavior across architectures
- Removed const pointer write violation in nvmem_cell_write()
- Replaced unsafe bit shift expressions with GENMASK() macro to avoid undefined
  behavior when nbits == 32
- Consolidated size validation logic for clarity
- Enhanced documentation with explicit @cell parameters (offset, size, nbits, bit_offset)
- Changed magic number 4 to sizeof(u32) for consistency

2. QCOM SPMI SDAM Driver (drivers/misc/qcom-spmi-sdam.c):

- Fixed address type mismatch using local fdt_addr_t variable to prevent silent
  comparison failure on 64-bit platforms
- Removed non-standard qcom,sdam-size property and hardcoded SDAM size to 0x100
  bytes per hardware specification
- Changed dev_info() to dev_dbg() to reduce boot log verbosity

3. Board Integration (arch/arm/mach-snapdragon/board.c):

- Simplified conditional compilation with runtime check instead of #ifdef wrapper
- Adopted logging subsystem (log_info/log_warning) consistent with rest of file
- Added error handling for fastboot command failures

4. Device Tree (arch/arm/dts/qcs615-ride-u-boot.dtsi):

- Changed bits property to decimal format (bits = <1 7>) for consistency with
  upstream conventions

5. Test Coverage (test/dm/nvmem.c):

- Created separate test file for NVMEM bitfield tests
- Fixed test to use correct I2C EEPROM functions
- Corrected test expectation bug for 4-byte cell with 12-bit field spanning byte boundary
- Added comprehensive error validation tests

Link to v3:
https://lore.kernel.org/u-boot/20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com/

Changes in v3:
1. Simplified bit field handling to maximum u32 size (32 bits).
2. Enforced strict size matching (size == cell->size) when nbits == 0.
3. Enhanced test function for NVMEM read & write
4. Updated NVMEM API documentation

Link to v2:
https://lore.kernel.org/all/20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
1. Replaced custom reboot reason handling with the standard U-Boot
   reboot-mode subsystem, per review feedback.
2. Added bit-field support to the NVMEM core using the new "bits"
   property.
3. Introduced the Qualcomm SPMI SDAM driver for unified PMIC storage
   access.
4. Updated the reboot-mode driver to support variable-sized NVMEM cells.
5. Added device tree configuration for the QCS615 RIDE board.
6. Enabled reboot-mode in qcom_defconfig.
7. Integrated reboot-mode detection into Snapdragon board
   initialization:
   - Added qcom_handle_reboot_mode() in board_late_init() to enable
     automatic fastboot entry on "reboot bootloader".

Link to v1:
https://lore.kernel.org/all/20260108065533.1143179-1-aswin.murugan@oss.qualcomm.com/

---

Aswin Murugan (7):
  misc: Add support for bit fields in NVMEM cells
  misc: qcom: Add Qualcomm SPMI SDAM NVMEM driver
  reboot-mode: add REBOOT_MODE_ENV_UPDATE option
  mach-snapdragon: enter fastboot on bootloader reboot reason
  qcom_defconfig: Enable reboot-mode support in qcom_defconfig
  test: dm: add comprehensive tests for NVMEM bit field operations
  misc: update API documentation for bit field support in NVMEM

 arch/sandbox/dts/test.dts                |  12 ++
 board/qualcomm/default.env               |   2 +-
 configs/qcom_defconfig                   |   4 +
 drivers/misc/Kconfig                     |   8 +
 drivers/misc/Makefile                    |   1 +
 drivers/misc/nvmem.c                     | 166 ++++++++++++++++---
 drivers/misc/qcom-spmi-sdam.c            | 202 +++++++++++++++++++++++
 drivers/reboot-mode/Kconfig              |   8 +
 drivers/reboot-mode/reboot-mode-uclass.c |  29 +++-
 include/nvmem.h                          |  40 ++++-
 test/dm/Makefile                         |   1 +
 test/dm/nvmem.c                          | 160 ++++++++++++++++++
 12 files changed, 604 insertions(+), 29 deletions(-)
 create mode 100644 drivers/misc/qcom-spmi-sdam.c
 create mode 100644 test/dm/nvmem.c

-- 
2.34.1

