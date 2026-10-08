Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FA2CA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 878F28128B;
	Thu,  8 Oct 2026 09:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id isILY19VDdmW; Thu,  8 Oct 2026 09:49:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D71D5811FC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452994;
	b=fboBEWPHx2l3Xnm5PGPvn262WqCUjaeXnCmlDdqzToaOTdSsQqkaRqtxF6+L+UlfOUHc
	 9DDJP1x7Lnw27oG8TdpLvZ0cimco2NZTnawGd/Q3/hEzpLip1vcxfRA5h4mIjUvPV0utw
	 PQoMCsxNFROm+ppWyFkIvKXS61D4oW6RT0136C0k5yWTTfstg3eM9iWe7uyUnsoW535BL
	 +Gvjb+zyoeApWu24Yxi1G+UPWDana+uxfwdcI7FMa81V33vnWVxRlaCS6cEadDEowh3y5
	 WVi+l7C7ATKZ5Z7494lX12sv7K3RvSbeSEBLzK/KIWQ59fbL+Osw0MvYCQJjZmxE9eQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452994;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	b=aIYF8MRAMZOfJOaVu5JuHto5BoV0o6VoWQvC6uagcMje49K21CLsAFTDpV/C4F6ncMLM
	 qB7RjGMuo+0+qcADUbAwJew7DaIJB1cc0zhvYVpFtgjLwoG9rU550p3cF+dja8x75cE9m
	 lZ9oOigMGTnyKcpc7Sy56omU0bNbk3Ud7+RX1XO6P6cyKd3dxrVNt0vjThjo1irRjuJri
	 Ei1O7p5o+PpDuJDUiG+R1s14alw8BYGEf7ptx7mHMlUtJVgeANRKweXk1QOqdJNpU9/3d
	 /MlLHv/R/dy/hSp7jpbj8jn9zk0v7PO2bM1OOhIO0pb4YQ9fiDtD/mV4jEK1/yNPzbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452994;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xpEvKwKCywhpl6QFsjZ0xQb5WnO/odstuonlhZWOvx5Yxtkc8vPixfeM7ghMrDSrx
	 D94TXlc5wzr8cO58GgauQJwfroGWD/rjuWlARp6amRyNR9xoFPzP3GwvC6nLzU7Dku
	 rLJ0JlhG8y1QHsVjVdZZAibUS4Ayb6b/5vtjFlk5l1/DPUC8ibDHGp32xHhSgcSUj4
	 Jo1gDmCHUWbjN0tZ9xiuh6JpOSc5gpCoPZiPyizprENgsPxvFrrgQVKzyHBtu03QZ2
	 BpIFPczBGMCxIWEZr1iiZwd+WXmiaSTYfLuUSxsBIM4bmPkhAfFhzyw9/RovmIvntx
	 pfO8PDimG/WBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D71D5811FC;
	Thu,  8 Oct 2026 09:49:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A221834E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93E9940944
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WC9q9ayRmrSh for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A65294091E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452978;
 b=NB61shWf965iEvbcUn0qoeW5CEAzDNjlcdGwVy1kHVTlyu+8r+txXOWUJ2Ma6Bxu24U8
 a2F7ds2KzvMu1TysgxBKcAPAYN0YLSdoidekQVQbU+jQe0uqr2wke4yP942VvVBGbUOml
 MpsXOLKKHC8B8MchvqG+EVSzdclAi+YptkZ/HLNuVympsLT8Z9CIhKpbJ0pXb+GSPHx0d
 KGPpWQb9YUsoml5uGbFmq7zzT8pLeWLJAvdezYO/u4ehIoGLVyFDuSGrs4BJUmpfkJjhd
 lKCcGsaV12hrrmmFkTYNLfy7Loqkn+0C+MtqXrfmzqyMMznW2foY8sCnkAVQqUPcrTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452978;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=rohrO1OqqFbZ4MHFSpydghSeKyKARQ3j+k/MLPeiAlrBN4DVunr3o9HUEBkcYtB6fuew
 9hQqLD16Cn0o9IIfMDUhzA/T/PtxAaR43v0YKsP9o1+Bv1LtdsHaUEWb0xuSyI7BIaqYB
 ixFXaqD5Xx9DzIY23lCoSmD8/vNsgs9SRbIJw6BOTz4grjFJF+qsKd0WnByj1rdtYWv2n
 OH53xjTCneEsizvLgF/q8OLbF8eJLHv3Gx0zwS4Q65GVdQO4shAz41CaYvQzPG3iLkNAm
 3atzrGB0gnMk5oaragcAIcmLxMpWNyaXqHVbUS5vxVDIa3kYTbqgJ1wchWicmEfGPkA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=TotYBxFz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VS6qkV3G; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=TotYBxFz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VS6qkV3G
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A65294091E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:38 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987KYXM730807
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ru8XYGxifVL
 sFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=; b=TotYBxFzHQ9gf3wwX8hDnIWRLwm
 NKEYcyU8NcmwMMnguRXhxTqYl80mR2Bt1lO9CSnLdxXF5kOlRLy9ooT9j3iDY7bm
 JYTG3xvSXkUS50a4QJdU3FVlR6SzF8l/UCUmu11/DnHqfgN7GVGyw6bWVwq+h9mM
 pHg6naqsQ1foilPsjEyBsM+PiZOi6D1LNcXB8NI9SeN54vAhWXSa4ugPA4sbYlAV
 lTqw7s2hEbPgjEzyqcz6vPFgczcfxK5Qjp6WKv5g74Vp8djVuVJz4R+V6G50zM9i
 Fgt7IYiXh8p9I6UbfgMgHaUIhtCdLF7u5x10LS7AFexDzwOvY0nHvI6Ut+Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe327sr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:37 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-14fed306427so17042346c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452977; x=1792057777;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=VS6qkV3GAdqvIGfyWpgMp9aLObkVcXbk/5dgWJSfVPqlhCDJHjO7hxCddXkUAXVYHu
 JauBpSeqF7z5kEXKr78blkdOjjjbq58h6ql8uICxY08G0y1J7+cunZV50ygSCHpiHXik
 5jUpWiRzX+QHbmTB/jbb5RmlP5ZH3uQCtYEcYQPTzp/RjSsH1yPERWZqKOeK0cBEPcSj
 bCLBbbGCDLzxWAVF17rgxoKIUx+DQVBPYYEANlevRDaj+7eoRl0F5obkUBhwMu6OznXI
 JhmRHG06HR7nMRLG215Jvyr4CR75S63qPxuNbebDwtq8VoeKUmZ74FpMZViabu3Hxxbh
 WnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452977; x=1792057777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=U8jqh6WELKiUpzdFLU+ZxuLeXJJ5d6uKFB6txow1//sdxW8tBAG71P/7l8gQT77SNa
 wNlOVm5tDds38b/QDidWVgT9/30jIngkg5JSOEd7CVYS7+bumQqqOtHuZkJovl7vNutK
 e7WIYpdBaDjvN+bVXSBH8rQLII5OPN5Kz3NH6LyxR+1Yh8Np5CYZwuPgjRifcZxOpz/C
 Zg0iONtaikzVL6dahs+dS3AJBxI8SQgMZSC2JixHVzPZGjcqqOjTVjjI2hKg9YbzKhou
 485BbLnWi3rAgEuMyraEVRGHM3R/UcBzvkTtumqXMO4iGXsFNIO8bQP/5pdL6ecB/Xme
 EV7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaTw3WPewlXSU2ek4HpEVEinP7JYOOpp1HJsVEhclQKMC0j9EuJbdrwQiC0EZw0Xbcyyb1lWA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mhYH12NICLihjOfJJvfnCP0jcAn8WsReo8JmNeenIi5yXIDDX9
 RiQeWBIGsyk6JlcBLyuJ/r+4YvqEEwVTNzxzlogQo6AhsjVln3XBADoT0abuch5f+kUSIWYPf6O
 oXFSCFUJc3YYxZIEKoKrxTXyRy1qsFC+1hNlAZdAddfGmP16l2GtZw7JuHA+bFm7lbsQrWGQ=
X-Gm-Gg: AYBFou0efjwwqyAqAc6m6JU+wULH0H1EFekuhgoyr0UI8pBe/AKoBY6V95h/Ke17U5A
 E3wBc9At0kirW6bs2j+fdmun5jFKVT+MUIxvzVHi4jvH2D/GO9RhQRnzHfmDKznM6LayDnPOOT9
 GBC2m6n87+gAmXDkDxUTBnVAwOCwm7ojzLxS40t/5Q/B1n86TRLPKIzdeAQe4/PoNg5iboREH/d
 2z1QbbGzUo3A9IkQ9WRKps2VJVapNzSx47Pb5ny7sY9LJWQLwQAiw+TRW7SA4JvevxOTcJrsamH
 LQViLA+zn6PLB7/zCMQbheugMauEMxzg1BWEuXKqQWlpkMYAwfI5G6woAtsXGfMSd8Yk3Enq8Vj
 w62yUkVb7vup8diV6xsCrqydSpu0WZW+y0sIDiD4VvQ/qFYc=
X-Received: by 2002:a05:701b:454a:20b0:145:4ef:e8de with SMTP id
 a92af1059eb24-161fd711bb3mr6019094c88.6.1791452976935; 
 Thu, 08 Oct 2026 02:49:36 -0700 (PDT)
X-Received: by 2002:a05:701b:454a:20b0:145:4ef:e8de with SMTP id
 a92af1059eb24-161fd711bb3mr6019057c88.6.1791452976287; 
 Thu, 08 Oct 2026 02:49:36 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:35 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 13/13] clk: qcom: build only selected clock drivers in SPL
Date: Thu,  8 Oct 2026 02:49:12 -0700
Message-Id: <20261008094912.419090-14-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOSBTYWx0ZWRfXwmVJwB8iH54y
 1XNl92p98TrOwenK3gIuJVvH1FomH2JAP4EUn+wuJ+pbvFo7NVUZBSdutdpkANLlLvD3IBPNEz/
 Gd9PcYE3V8yjtrRjaJY/i9tShcvVqHMpCNpcp97YGNVulUDkTPI3xtzJljmXJjJrr5vyfW6Vyy+
 8R3MLSnI8nU0tTzKBxn9fiSsYC4jb/M7g9DKgNL98o49e0TU8uxVhe8MJgTefMWl/xtzDFIgUc0
 3aiwvPj9Vd6ktFdw2mDjzj/RckdNlQLr/73W4hTOZ/YpzLg/c2JrQ2H0nCyFrNnjyAa60EOHCuI
 5bSorZ/FjP3D8X928XMlOkMN3c//402AG7JeTHuFJT69+1SONb94jgf7RwgMkWpxPJ809Q80X05
 Wzvv0sw6lSkebH5FuIbdl28Eohio93yCUIk0fvM9BI2TK1GQFdc0Cx1hW4rx7DMgm/FdEXe4OrE
 9V8+Ucr6ajYTJr9d72Q==
X-Proofpoint-ORIG-GUID: sD_TRK5LXIHlPO7tZOdIXmSqaXiTJtMB
X-Proofpoint-GUID: sD_TRK5LXIHlPO7tZOdIXmSqaXiTJtMB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOSBTYWx0ZWRfX8ut4OG4QLsOj
 wQSn4FRJe951hkuxTW45etchmE1cv4IA8DAyrBcUQ2HX3aNhnm4FLvDt2lg/V+lMtKI+e6KUZM1
 MfdtoVx8niDHHyW1ZJcOLyOrxdJB0sI=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac76731 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=1OAO5j4Zegv94xHJGxAA:9 a=yafjnGloKYvRJXMp:21 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080039
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Make Qualcomm clock-driver selection phase-aware so SPL builds only the
drivers it needs, reducing the SPL image size.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig  | 208 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/Makefile |  48 ++++-----
 2 files changed, 232 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index aff3f5418a0..899f44cb8dc 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -5,6 +5,11 @@ config CLK_QCOM
 	depends on CLK && DM_RESET && POWER_DOMAIN
 	def_bool n
 
+config SPL_CLK_QCOM
+	bool
+	depends on SPL_CLK && SPL_DM_RESET && SPL_POWER_DOMAIN
+	def_bool n
+
 menu "Qualcomm clock drivers"
 
 config CLK_QCOM_APQ8016
@@ -15,6 +20,14 @@ config CLK_QCOM_APQ8016
 	  on the Snapdragon APQ8016 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8016
+	bool "Qualcomm APQ8016 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8016.
+	  See the help of CLK_QCOM_APQ8016 for details.
+
 config CLK_QCOM_APQ8096
 	bool "Qualcomm APQ8096 GCC"
 	select CLK_QCOM
@@ -23,6 +36,14 @@ config CLK_QCOM_APQ8096
 	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8096
+	bool "Qualcomm APQ8096 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8096.
+	  See the help of CLK_QCOM_APQ8096 for details.
+
 config CLK_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 GCC"
 	select CLK_QCOM
@@ -206,6 +227,193 @@ config CLK_QCOM_X1E80100
 	  on the Snapdragon X1E80100 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ4019 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5210 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5424
+	bool "Qualcomm IPQ5424 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5424 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ9574 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_MILOS
+	bool "Qualcomm Milos GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Milos Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCM2290
+	bool "Qualcomm QCM2290 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCM2290 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS404
+	bool "Qualcomm QCS404 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS404 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS615
+	bool "Qualcomm QCS615 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS615 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS8300
+	bool "Qualcomm QCS8300 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS8300 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_RPMH
+	bool "Qualcomm RPMh clock driver in SPL"
+	depends on SPL_CLK
+	help
+	  Enable the Qualcomm RPMh clock driver in SPL.
+	  This provides RPMh-managed clocks needed during early boot.
+
+config SPL_CLK_QCOM_SA8775P
+	bool "Qualcomm SA8775 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SA8775P Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SDM845
+	bool "Qualcomm SDM845 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SDM845 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SHIKRA
+	bool "Qualcomm Shikra GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Shikra Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6115
+	bool "Qualcomm SM6115 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6115 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6125
+	bool "Qualcomm SM6125 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6125 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6350
+	bool "Qualcomm SM6350 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6350 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM7150
+	bool "Qualcomm SM7150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM7150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8250
+	bool "Qualcomm SM8250 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8250 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8550
+	bool "Qualcomm SM8550 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8550 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8650
+	bool "Qualcomm SM8650 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8650 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SC7280
+	bool "Qualcomm SC7280 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SC7280 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_X1E80100
+	bool "Qualcomm X1E80100 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm X1E80100 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 8da2ff7e73e..7c4db9986d1 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -3,28 +3,28 @@
 # (C) Copyright 2023 Linaro
 
 obj-y += clock-qcom.o
-obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
-obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
-obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
-obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
-obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
-obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
-obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
-obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
-obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
-obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
-obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
-obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
-obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5210) += clock-ipq5210.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5424) += clock-ipq5424.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCM2290) += clock-qcm2290.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS8300) += clock-qcs8300.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
-obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
-obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
-obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
-obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
-obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
-obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
-obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
-obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
-obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
-obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
-obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SHIKRA) += clock-shikra.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6125) += clock-sm6125.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6350) += clock-sm6350.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM7150) += clock-sm7150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8150) += clock-sm8150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8250) += clock-sm8250.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8550) += clock-sm8550.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_X1E80100) += clock-x1e80100.o
-- 
2.34.1

