Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73D606A33D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HkE6xyql;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FRnhYT/i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dZSeYjAd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2898280FA3;
	Thu, 29 Oct 2026 10:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZnbb3ENnzSc; Thu, 29 Oct 2026 10:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A5D580FF9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271491;
	b=lql4Q7tGHumsxDeXwktps2ZWYQlYNGwEvA0OKXeChywlgqmlb5P25MsSwSJ0P3u4O0sl
	 GL4NYPjD6tjAA416Y9TSaVrDgA4DT56U3epH9wiPZUK/8XKPXfirDhiGr0ivu4z5GCZkA
	 8u6tgFzA+QCrvcfl/zIhQQGgdkFQdX51LKmKkL3dHbaBYJw4vQfb6AUg4bxTRKdU3/yHZ
	 J86P6kWg9+PXy4gPVne6zia2OFZowa1BbrGgzWB3wQss5zVCdQKWipxUpp6bPcB7Oy96X
	 RJbcykLxgL4yrI7uBiCLVR+UTTfVeNvBOkoVc0gpTQsRU1wcwxcprSuu7B0YzNgTEbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	b=Olx+AcwTSLYH8X3HsJOEqZ//xMu1V546TCwg05HJsw8KB3cfTDu/3MuIu51LfAVflxjL
	 xRATz0KL1rNBBs6EtQFov87zYOXKWYv1dgVWv5I8Q5GN4SWvTGmGLuRlLhpIrYdb3iImQ
	 bFSKvHc6yAxcWkZAy1J2IFSXDg3Gu3G9NlL7ZjLZLpDmNdBcQ7yJPFxivN3TxCehX6a3I
	 oCzPR0EJiZ8vZ66+Bg/F0jvsetIvsFF6dbSWvWZLHDgDUlAIxwz56hO2jFYOSfiy9jYPA
	 uxwst2Hl9p1i3eDkxs3jlxib2fPMZZjn2OMx/vRjSURhGuuYm+DrWoJO6HfCnHwj2xw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271491;
	bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HkE6xyqlrwiineUcXR/Wr+GV55DGs7kZwlodbzlXXykqpudOya0LQn27Q2Nmw8Su5
	 qtAuYkFMZKAqmdDmINQ59g1A8iOCdrp5UFocT2HP6DdE3XhjkxLbnnEr0wEEmb+BXm
	 5weRzeethoSGbGFKeTr48W//LjuwAuWVX+Vf6nAh9zkBqEedyKTvQjCuWKq7e0w123
	 CUaw2uvirmuRzfnC+5u/nH45rILPmPD6cySNW9CFiJHkj3IEi3VXolygjM/DPrQDQO
	 N+kLjjnLXsV8cGWUaSRnuVJknUETKDcShKaKuCSZKuQkiSuwTxR/MVgq7IXoNCjVln
	 7rD/9qhQQUI7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A5D580FF9;
	Thu, 29 Oct 2026 10:58:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D46881DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BAB664032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WANsmQibDidk for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:58:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 36BE640024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271481;
 b=khRMIHJsnkEFPpHLTQCZjAdwyfdG2rK1eqNYd1Yvhgdy/Uxu+M5B5DjNQ7t1BhzS9iD4
 WW1xrtH3+lm4rsjhcWHeOUenL0rxX7vyknjMM4QnE5FlJepSb2H78n5xtyn3BXeXX+bzG
 IfatFarCB7lwzK9BrKsNtJxOomeOFK6xmMs8Wif8+/e0YCKiFHlDSI4yiNVHQv+d7p9qF
 NbX2xlN32y9+692ivcw8FQlkrTOhPokNb/F+NHDykFH25cNowGHEcvMeNiaUPyArzvpKm
 ZqeSbv+Jo7Dx8NoDenl2MGyppwmtZ7K3l0GcEYd9JmbBiquRK5J8SjVqQhDuJwn2Veg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271481;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=BZ5Qye5VolJafOloooUOZLSxAGtesirerVaFtpFUw13MZaPmzJomSgJSy45WbVwtNVFb
 mHJBvxkeXtR3hxaui9V46qvlYkk9Tzq/RiHSENiMCCUPA6SOQ1/LU2hr4T8YdkwyZtlT1
 BRu7qsVelX4Qf37Dl4zPYbjxjNptDfX1R2L12fXHIThMvwUm/08HhPBuim15D1ogsbiXf
 p/g2H8WPm/n/5mAW3MDEMNpkYwhShyGIYMKyRGmuz4JFRFApJC3ydzPeRctsZKsqNBBSn
 uLAdwsW2xm9GYOTlpCDObubupKhV8NaLMVm+0MjxU7AmMsZuS4oI6rK8mgQq1Ufqrfw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="FRnhYT/i"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dZSeYjAd; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=FRnhYT/i; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dZSeYjAd
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36BE640024
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:00 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vvml3279853
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=doWJbh7Fqia
 lYmi81CmpvlL5mjRVCir1a9mrILO97bc=; b=FRnhYT/iCshq84PADdwZ/kobcVx
 heidxm9I8qj2+reRuMuebOOKMx98jfn8NUFlxVMoMokVbJk/4QaUhe708i1P14CV
 veBmAQvRsqkZerpv6Pl9+B14PePjOcLQBWcRelaZan55SsQz+SoEsk1JyEUwhQnu
 XaWV3lWn5qfdKI9WE01GHGD6PQwNgJUZwcsX5kBJ3gQXrtcSWAGhfk/E6K57pzr6
 UEelGoGibFGrzRr53yVcFIIdRuKBj9fzu2PK/Un7tiXQ+6VkAb3e2RivA7wgmnnR
 ax+o4A1POfLbBHhNBXhK+8h5OhXadjvjKGBJPugidvaBKbQGZvPzxGcUTrg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hks3nan92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:58:00 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso4327114eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271480; x=1793876280;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=dZSeYjAdCy6otfn2grEhF0RSX6ojxcpVOTB2gjN2/nS4+rxaaFxKFC2f2rpZkP9m84
 RZplZGJJXBF76WSCS9zlX540eHOOKCOdW+0BP4U/zbfsMNHWr3t9a3qbxlCXq7DJMuKg
 sxp3COZ/mcrwcSujZMZWYuIBhMCvB2rzX2RJjoVzM7c3KdfzlHRGFWqNGuKezPbp6mT/
 xPigedZypnxanqY2UwQXc86b8+t9uxA1ZERW4Z0QyMo/s0PeVVUyi4Q5wGFV2otNf16X
 NjS/Z5bMIjxZ5CtVMGED67QnNZH+hK6wktRjJ3cLiH36Y+dIt1A0Zp9buHU4F6FA1A6m
 UYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271480; x=1793876280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=doWJbh7FqialYmi81CmpvlL5mjRVCir1a9mrILO97bc=;
 b=xwL4MfHeuARpwj9SluwlnXeTxiOXh5wqW0oQbMisvnu40rvco1g/RcQ0n8dSJxXAB/
 cGob+rJ+KDy+y7DjlrDLYtN8SHR/iSvtsGAyKPA6xwdQKA4uQMZCpCHxei/5vIdYbyHV
 EIfghGTyy59h5Qtofc4dHfhsQBYEttSNTIumwX9UmjlUroRtzUUOaKyIGmF+jU+DmjPo
 FDHMU5JxX20AoO8LU8CfE330h/IN5iLJyUoM8uprEo8Q5gC37eRdx7VGstA2GErlEBQf
 ZwDMvn2JWFaxQ4bGIONvp3CYufPBFnGn4wlvIUBnAVtwtmw4omI2J/HQ6hfCR5rGmSQE
 EnAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxv+InxREVmfAn5XbhyJSX1mwS8j9GYqNXOiQwPazP3tfa/JuD2Bu617KK6HHnGGmB/2Dg9fnk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKuMjk9Vwp2OewdcNmQ9iAvji+87DlshV4STxcUtlixFpwkvYyU
 kBW4bYoNDcSuCeDyeakC1c8lPg6lDTzUaLbJfFFGEysUtuntIXZC7ruA3DsEwYcAgyXUeIVECdb
 TqNtaO63mv3LEHdXULF26N3Urkqaw6iE6xSIT/JQElbabYJNfNhDrdPjZwl+WNmlJiZ8e5Uc=
X-Gm-Gg: AYBFou2XezMFriflUd614zdVW5kOb9d+IZRV0smtJ4+RwiZP9eiUJCuO1hEBLK98XMQ
 tHaHqAUVyNwEJOQq8JbkQLMlsdCEO1WLVkSHfb0+eSN3JIZmq1BtxfaCQVFWmu8EQjY3IE5teCH
 0nEZJucpVTyC8hljVJVeexECUHBCcr5stnLFZU9z7WOoDdTBxsy0xg4O2xFJXp/a8cLv3++jxS8
 +y/AQ476ob8PYoqiYO5FvMxAzDWLMSas5zk7mqjeiZt8BhOHtOx7vdzNGCsa1q0v8f7iXFzR836
 HCQoW7oOtbng05WgEqf2N/0W510r9LI2LSWITpjNOTwA4KyEGYW9olepPHyef/zPnewS8hBPGtr
 0afjxZll3pCWiFn3M6Sjj7a0v02d05IHltUvCOXfd8WRzlvYgNU/rRwPvmmeqe1ct1e7bkItRsm
 Hbu5mHtw9LIAHc+nKDNpvwQQ==
X-Received: by 2002:a05:701b:4517:20b0:17f:7280:1332 with SMTP id
 a92af1059eb24-1a6d059e59amr6533084c88.40.1793271479398; 
 Thu, 29 Oct 2026 03:57:59 -0700 (PDT)
X-Received: by 2002:a05:701b:4517:20b0:17f:7280:1332 with SMTP id
 a92af1059eb24-1a6d059e59amr6533065c88.40.1793271478891; 
 Thu, 29 Oct 2026 03:57:58 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:58 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 07/13] clk: qcom: enable Shikra QUP wrapper clocks
Date: Thu, 29 Oct 2026 03:57:40 -0700
Message-Id: <20261029105746.3487456-8-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WWWFYkg2rs5ksji9kvkl4xrR4HqfGuor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfX3sr+Ac74+SyC
 OdFVo52GnA3y0bmg0EBM630m2+crpPfsbO1kP5EadtGEY4psFGI81myfoAf6EETIVqXNDKy+qQB
 Lq+DoaYTiyFIEZpzwgMbfHUH+lj5cz+t6IKrGkFEzSvBSWq320QFIWnVTIDaOscXUYY1JRPjP3F
 8gYiewLZeyak3Ox7NtPk45Lw4hLcQ6uxyYqailamRZVzgpygVQEOEZC+Yhwr/KFVkW7TBxcXUmZ
 0bJVaqy1+RhO9HW4a5/zgAAweDl5uKkhAfJsTFH0U9JQL6JU+v5K5exTghrkDzmJOACLzI/R2T4
 pncuKDcA3u2jLt+o1u0RVVoC0FxibgvU5cPjPoww2KV8yGvyoqmzxGobJUVh4fb/cDG49D68Smr
 2dfAcLNCQnWpqoIzi9V3DV21ES3AG6JMj3D9CDijKEDVF1AsZWMTPa4Cyr8xGOeeMNtbSo+Nv4G
 zTKKzvcivhXHfM2M/Eg==
X-Proofpoint-GUID: WWWFYkg2rs5ksji9kvkl4xrR4HqfGuor
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ae326b8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=mb1s1FuMAeZDaavxsqsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfXwmbHc3L+pXok
 bDm001+Ige19YQBiIFjLPJ/Q/4sFFnkaJ6XOYbwJhdAuEpasKYtSrPsb2idQ5txkD5/rx/9AKa4
 E0+HFYLHzqrw/tXbdBrm7SocpmJ+bSg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable QUP wrapper CORE and CORE_2X clocks whenever
its master or slave AHB clock is enabled. The wrapper
requires these clocks for serial-engine register access.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index 94501b838fc..a74d529f4cf 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -315,6 +315,18 @@ static int shikra_enable(struct clk *clk)
 
 	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
 
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP_0_M_AHB_CLK:
+	case GCC_QUPV3_WRAP_0_S_AHB_CLK:
+		/*
+		 * The wrapper's core clocks are required along with its AHB
+		 * clocks, but are not listed in the wrapper's clock specifiers.
+		 */
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_CLK);
+		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP0_CORE_2X_CLK);
+		break;
+	}
+
 	return qcom_gate_clk_en(priv, clk->id);
 }
 
-- 
2.34.1

