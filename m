Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC008CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8653080BEC;
	Mon, 12 Oct 2026 17:37:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Umuc5s5IK9Y; Mon, 12 Oct 2026 17:37:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 64C5A80DB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791826650;
	b=f5yMvhSlEjrc6Ac48h9HiBWM/VgTUGDxyMOPigaNrWBabp8B3zKVRFHa42eiDQ76UJMl
	 8VpREVlGJ/HKFTRfTfW4a1vkgIR0C35+AzVlcXFJyzcMeIufj4N3nkoHvsxzC551VhCJ4
	 Iys+s7TWsd48p7viqXdljuYFLPHEZEuCkntN504DVNBuVfU0b7seJBMKwCqkaBOtSXfrq
	 DeqogEbCNv2nrwuKHqPzus6ZNd+60G4y+hxRnFjPhgcm4oNsZCpCFvkE8Ph66fI3nJ5oe
	 QMpDPnUJ2tBav++Q8d0SSq1+zIi5hMZSqGIUMs50mehbTEHBki94atT8IPTDkXSYDkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791826650;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=syRM0OUaBbo4x73Mz+Sg1ivHTjE9xqOZZ4PQ2I2i1zw=;
	b=TXf4o/kLbNMzUO6+VJDTVsN7xpFMDA6N9Gm6XB13guLz7rFphAlZhvwKMZ+KuQ1HeDxj
	 LdtqPuwEnO4c+Bwe1/zwxAgOIblZ+xDejAVSNQUA3oDeEtWkln3mmH5edEapaQcJs60ED
	 hPCxhhJQZ29Z1qqRIYx3/7ImvbOakBaTYBlMD4sD1J8iTgA4mNny9QmW7P7CqJFLcZQD7
	 0FcfeK/gSM1mb9iby42YUDZhw1hTLYt0sLCHBNHDNQGOk0FFX6EJ5KagyLn3WvTngBR73
	 xwg2sq+LKOpwdAojNkDJE6qrMRMg4SH+j4UmQ5oc3Lv9d/TtbOGERhfDyHMQ1gbxffg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791826650;
	bh=syRM0OUaBbo4x73Mz+Sg1ivHTjE9xqOZZ4PQ2I2i1zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N4OwbyvGl4wD1CgsrmTVL9BRss8aa6qFICmHS4WacF9+tGS4peqYeCaB/n83BElx9
	 UR5H3eKtYYkp/iPjeqZ2ZDYC9WASEY2KhrnLbc6+ryjDOhXzhTL9YZhoWVtLD+dY2G
	 zVTvWmEj46MbDkgSwc47xnnjO/7VTaBBR+4jTpCRHD1fye8IQw4OeiKLKtE+2wdsuX
	 Lagay3ovlEtk1n+1bo79d8QmfajPmbq9Vykaq5bTdVGtjK3flc6Rv+OyKOpxSaGetv
	 g237/qZCyoMB4M7PF+bErRj08FFx0ama9pAxFnhZlI88jYDdsaFbATWWeQYkbuBQqE
	 JPxLp9PMPA8Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64C5A80DB0;
	Mon, 12 Oct 2026 17:37:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1063A105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E26C40586
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HrUZko7G-xV7 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:15:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61C9540581
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791821744;
 b=AXPY9UBQB/Att4i0xicDd2VWpooBMzN0Iljno5TkYY+a+LVJiJQuL6wAR8cnJdM8rdD+
 5dz60nS/7b52//80yddvrRoo7Sx7AJeMh8uoPiasIU2PtqkUWeqH/gW8HGOLPYYV0IoWq
 axgxYhZObiD8MUIbch1nFRCBQubFaUCCZsvzifn10gVdLiw3eBr9ZFSHmDIkMvko6Vnt0
 HPb2QOYFi/+RVU4dxMlnZ7Yu/a8Tg6YXDeHpDBsVeCzHDpEdf2Jq1MWUc4wJKGPPXxiPQ
 1n+gjsgZNt+D+i29LzDf7TvJD67CNQ5EtNEjANaz1pYJWo/OfbaZIEHgNOGuAriVH0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821744;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=syRM0OUaBbo4x73Mz+Sg1ivHTjE9xqOZZ4PQ2I2i1zw=;
 b=CAGUjJtKvZtKhL5Nj6eRVHvEYqTOpTbrzahSqnL3PuTrZ1a+BmxObRkqGvdYMOBNy6lt
 ACSUOtQDJPOO2XAAmQeNItYpMO7FjiD88sAHhY1wxqGpe4s4ETJHnQnoVDFb8JjfNL8OU
 qQIxE4EhfHEq2LLHI/wvJin3+H0nUOy7aYINlLD1hHI/uUvE+BDQh79HHer3XBn2q4BE2
 JzJNaSdt82TrbbQqv0UKa3z//NfBpXooOLT1+U5QlMa19pDcT2o6R3ZYp7WF7s7LE7WEp
 MHvc6g9atlnI950uquarqO2TYacB17WH/542JuPohRJUVP5NBCbCR/SKX/RUPV+Uuzg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CKqSSHsc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jUs4aZA+; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=pavan.kondeti@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=CKqSSHsc; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jUs4aZA+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 61C9540581
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFfTJ32768456
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=syRM0OUaBbo4x73Mz+Sg1ivH
 TjE9xqOZZ4PQ2I2i1zw=; b=CKqSSHscu9RVXdsEZZrAjsj7+sUDndmq19zFj2Xb
 Qxzzf5UYrhFyH0+JtdSeoYJz4mqJL05TjNKiTii9CIOr5EONBFwwY822q+U3Gw6t
 qAvSXoKE5DfMcrKsstKioUDyveueVSyr6srV/gw99B/b5VzxPkMmZMv6alK+mJk0
 5zxzoQH9RkRuCDbuINwi38z48kMJbBuVR6htrH6CwB745dZGhrCe+k+uqkbspBul
 /ZITDbgKBQdjG0mjEIEu10IsEU+6ey+JUeQmVNmCm342ZjpzB8jt93g/qajHvXbr
 XzSpJ7JqQN/L7blp7ZOLqkzKoFRPmiOdlnem8YIai8XwTA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq29ed-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:15:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso1436831eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791821742; x=1792426542;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=syRM0OUaBbo4x73Mz+Sg1ivHTjE9xqOZZ4PQ2I2i1zw=;
 b=jUs4aZA+tqR03BIeyl7PVvvgst5PvDcJtL2KjqEkLvnzi/4U6axEozDzcytUwQZXtB
 XJdGuV91RZT60WnWkvMlwYBZwenZ0+BRUbinQeTQO1Q4ilv6KYk5H29evvsgmtxSiC3F
 K/FeVOnIyRjKm4Tqzep2FnoTQw5FuVbMOvGmYwf9Ck5fMlSECF9j9QjLsDNtWiFywf58
 8VBrxDizEl+81Pjhl6Lf/54UNOadhYutJvm/4n0IUQ6+uUOx94+JL3c+rHFfoVt2/jsa
 kdKbS4xsyJbwvLbHGrktUL/n/SdMYzisIZyf1muJIMxKxvYHZItKRBqbDGE4P10rX+XE
 VBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791821742; x=1792426542;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=syRM0OUaBbo4x73Mz+Sg1ivHTjE9xqOZZ4PQ2I2i1zw=;
 b=GnZs0167uJ2M0z/jkJHS2VdLmkauvDYBIbHEMf7fmZ4ObVgaz2WNsiwfmRkqa1sGRo
 v2yPf73+3RGlkyG4F8k3tPs/t7luLIASf98S8dwxeZP+qFOTHJOK+lJ7U852N/WL3zUh
 Zjq7vfg2cNGyRii2QqQm5vogV5W/t1od4ZdFz+oVO4eLRSytjsTVTX76jHKJ4Zj8wcvK
 zlV4cRzRLMm4k3vnnE0oLpHPilryYuMsMRj77bKSr2MBVRqTd2l0//bvURwwqtI81s4H
 0222iNPDULY7jjgERWGh94jN5QrCSBciOxBTXt4PJAmTN8QLsgkvMocPXOtq0M+A73O5
 GX3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlHB57IiTHUr+UMkBrUOoTMZPs9udZ/iHt7nJlNSDoCP59KexmHelyUqYw0ldUtC03djDWyPY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI6COXspgmjR+yqAxlvEQD+JaSnACce7hZKMSaIEWL8TQTJm939
 ReQpzBzAvhUSKnf6zZcbCAeDeaS/EUIybpvq47pXSpWAwYozu+c4YBUtRH2MtCSlOr9J6iJ2fDb
 lG5Mm8N+xzxxWAPIYTDA5/FgI8QEVPso8GUMV0eZgmVgxgshdzEK2YCRCxlSTRuv7UwHGnWg=
X-Gm-Gg: AYBFou1QXbFcZS2/JIhDHMd7ze1rGKb0NQHdjSKf9DD+1TMiIs2VXxn4qESvCs2VDSV
 PLcMsLjxnZBfZ85YIX7rkH3F1PaZrsd9+zbm7OS9N0MLta36Ntjel1bOGVKuoU1UaUS9LS4r0aC
 m1mfZajeXDX3yK5duXJamyyTaaU2htW5rzSl5SBQeacPS/g9syhrivXq+rL1lS9Gy30BEkwRxpB
 fsX69cGk9CGHcYEMAGppiA7ktE26lsO9fTI1fCdaGGGEsMmQXTTQB7MeByNB6fO5QGCnTvvdgow
 UVT/cI0tuF50pZt06k+aA1jTlm0gdRZUsK1Li5uFLq6fR5IoGmClq1xCmdlcomwZ3wI+evd9/76
 vQciXCIvdmqh05qfKz+adIz05w6WrnslJ
X-Received: by 2002:a05:701b:4585:10b0:14f:5870:2e9c with SMTP id
 a92af1059eb24-16a15460f46mr12378604c88.23.1791821741663; 
 Mon, 12 Oct 2026 09:15:41 -0700 (PDT)
X-Received: by 2002:a05:701b:4585:10b0:14f:5870:2e9c with SMTP id
 a92af1059eb24-16a15460f46mr12378524c88.23.1791821739908; 
 Mon, 12 Oct 2026 09:15:39 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a2d2db98sm29443245c88.10.2026.10.12.09.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:15:39 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:45:34 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Tyler Baker <tyler.baker@oss.qualcomm.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 3/4] board: qualcomm: add Arduino VENTUNO Q support
Message-ID: <3f4648b3-ccee-466b-b209-fb429aaee803@quicinc.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
 <20260928-monaco-ventuno-q-v2-3-0e046c8242be@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-monaco-ventuno-q-v2-3-0e046c8242be@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acd07ae cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_PWTDTcfk_6k7A8QPWUA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NCBTYWx0ZWRfX9RyMlE4xkTuN
 eHhyk3adU6sBIMwVHH2cp+srCj8uo06G+Gc6QoMi4sOSWeSc1cCxQiYvXBkjh66/gheSNwPv8rB
 6VG4HwgWh2M+2/SBHpC9IxsptSIZky0=
X-Proofpoint-GUID: 3ltGixkD9-xJDXcKeosv2N6me9s-MDs5
X-Proofpoint-ORIG-GUID: 3ltGixkD9-xJDXcKeosv2N6me9s-MDs5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NCBTYWx0ZWRfX9p/FquM2zkK7
 XAm81aDneYfphtzGKbui/RaAzLPzWBVHUFwj+YZAnHEPG4ReGS9Me0D+80UT7irAYEWBlv1Wm8o
 ENO6vOzaIwsTz6sDmnRhPdZLrG2hZ7o/HV+Oss/K04vRf9IsBNOsZYAwob6nr5MrMcmXwjHXnqG
 62Qp3RVs/39X1QUGA8cmceba0ycyR3a0WPO9PO5gHh0WA4lY9geeIQEo/hqyTC6O+yaoUqD657s
 dZjhNqBkCHp4cF6qe3syXv/T1efMYIITz0PyWz71vuypxnj81U72aYP2df0AcKWWPL0ZhnrpxW5
 Id5/LdBCVya0Y2vu65CibrnWvkd3r1rLVu+Q7qDR3YNNWGVwz5SvnCyxqLturKn5BP0Ad9nEqrO
 FFDchDBcDurs256Avc6joERiT6u10JxoRKhLgLkCuJz/eWazWJuVcc5cDxQaCEMICXRIb6F5Rjk
 V32Ow+0wqzlqQfUbfjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120064
X-Mailman-Approved-At: Mon, 12 Oct 2026 17:37:26 +0000
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

On Mon, Sep 28, 2026 at 02:06:53PM -0400, Tyler Baker wrote:
> Add a configuration fragment and memory map for the Arduino VENTUNO Q
> (QCS8275), running U-Boot after TF-A and OP-TEE.
> 
> Boot on a Cortex-A55 and exclude memory reserved by the boot firmware
> from the RAM map.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> ---
> Changes in v2:
> - Renamed from "board: qualcomm: add Arduino VENTUNO Q config fragment".
> - Reworded the commit message and comments.
> ---
>  arch/arm/dts/monaco-arduino-monza-u-boot.dtsi | 26 ++++++++++++++++++++++++++
>  board/qualcomm/arduino-ventuno-q.config       |  5 +++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
> new file mode 100644
> index 0000000000..e6ba8ba486
> --- /dev/null
> +++ b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +/ {
> +	/*
> +	 * Boot firmware regions left out:
> +	 *   0x80000000  SAIL
> +	 *   0x908c0000  DDR training
> +	 *   0x90c00000  SAIL mailbox and OTA
> +	 *   0xd0100000  TZ carveouts and DBI dump
> +	 *   0xdb100000  TZ statistics
> +	 *   0xdb200000  CPUCP
> +	 */
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x90000000 0x0 0x008c0000>,
> +		      <0x0 0x908c1000 0x0 0x0033f000>,
> +		      <0x0 0x91100000 0x0 0x3f000000>,
> +		      <0x0 0xd4400000 0x0 0x06d00000>,
> +		      <0x0 0xdb300000 0x0 0x24d00000>,
> +		      <0xa 0x00000000 0x2 0x00000000>,
> +		      <0xe 0x00000000 0x1 0x80000000>;
> +	};
> +};
> diff --git a/board/qualcomm/arduino-ventuno-q.config b/board/qualcomm/arduino-ventuno-q.config
> new file mode 100644
> index 0000000000..a8041cbe9d
> --- /dev/null
> +++ b/board/qualcomm/arduino-ventuno-q.config
> @@ -0,0 +1,5 @@
> +# Arduino VENTUNO Q; use with qcom_defconfig and tfa-optee.config.
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-arduino-monza"
> +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
> +CONFIG_BOOT0_QCOM_BOOT_CPU=y
> +CONFIG_QCOM_BOOT_CPU_MPIDR=0x10000
> 

IIUC, Linux makes CPU with MPIDR ~= 0x10000 as CPU#0. This is
conflicting with the `reg` mentioned at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/monaco.dtsi#n53

Do we see any issues with that? Also, what would be CPU#1 in Linux?
of_parse_and_init_cpus() indicates that CPUs are enumerated in the order
mentioned at cpus { } which means physical CPU#0 becomes logical CPU#1.

One immediate side effect of this is that `capacity-dmips-mhz` value
will go wrong which can result in suboptimal scheduler / cpufreq
decisions.

Do you plan to patch the Linux DT as well when this change is enabled
in u-boot / bootloader?

Thanks,
Pavan
