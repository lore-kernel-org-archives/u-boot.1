Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB2CCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5B4980D84;
	Wed, 14 Oct 2026 08:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VE6Tz9phA-O6; Wed, 14 Oct 2026 08:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A2BF280D4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791965576;
	b=e4Llzw61Ac9Na8CmoPvJLda9Rk4l7hH7X8ytvcIfPRR1AuybTthRVw8CTQhQw4cqRqwp
	 XUc6RFy0VUqGkx2ODX8X1vKdABM7lSfQA5wCbbP8SiElrTfD6SLYlhEUEwdlpbhESJZby
	 Tz61d1MuckbNZdG6UKZ3QW6EDVFjIThv668zEGmxCapu/Jzw7qiav31ryBLSONV4MZUPs
	 gBFCoU/Fe+fySTVo1AeCDeDWbsLb7/SpXFbgBQdQH9Txy36cYHHFWImlOF8j06iW49MiD
	 XzWrvyDVYzmtYOSLl6N5zO+jxEaSLyhtovq/Mt3WKPgMxkBT/RZCcY/7z+v8W6N8xPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791965576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NP9pDWhX3KjcLWITXWO8GRNDDuYPuZ/iFYrrq2zkJrQ=;
	b=bgWX1C8P6Mo4KJKALSVvnctxOC+wP+oiU58zl/fBiI3zdCwW+Mj06q24ngQVmZyID2q5
	 i9jsrY5YdPcM6/E5ZWuXzjsdNBKMsrcuFAL69wFJnx5tieQgWD6cOUdYU9Tfl0qlDvisn
	 1NA6I1UDx1afPjx2Glq3U7P/0wSuBf4p/NRxppBDZwI0l5KIxvxoaBUs44fBGB/e0Anho
	 7GVw+8Lphb8pT8fsDndUgqT7VwvOwDKqiadAiaT9YUFOw0+B/tVQUv5QPonRt21YqYuwA
	 OBDH1dNnJS8+CBKsZNntFY1/ptUepbkZlmduOPWcpoHmvK8XNOQHp0NPf8iPCsJPy3A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791965576;
	bh=NP9pDWhX3KjcLWITXWO8GRNDDuYPuZ/iFYrrq2zkJrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dBjA7am3UmbVMlAWsl5PWSSVaPGlMvTA7zs4ATPDAjZeKbGFYp8o6fC5JxskaPXWl
	 4GJPeY2tKAUJG9rHIeM+4m4tBhCEqGbVBxTaeMckD/51s90cY4Vxc1C507daClNKlK
	 60k2yXF2uYDncl6hqGbMeef+QddTViiBo7aBYECzwzzTY6ni0l+Uf3pv+hsi7oTyGi
	 ZsyW68pseR7LxNly6ZGrcJRD3svn5Enq4YSokeu/K6TJ9xWNBuRhCH/WGtZnA0IJ/z
	 hSsvSyywqnx2ztmY8nGg4iPkBM6a36tpGWBYTYvHOOuCBgRk6YeI6ivAB6nlbWKamH
	 0jc97CA176exQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2BF280D4A;
	Wed, 14 Oct 2026 08:12:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 111EE75
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EAE9A406A3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGztPfq7WyEm for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F26140602
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791965574;
 b=fvunCDKxdD01PG2GGzFszN70r1Cnw6/JT4Ja7SLItF9nSf0mauUWplwB5MGEd32pH8Fi
 wUkjX6p4LhAVD8X52P7Udb10vZA5AZ+cS6JDECkmHpOT40TpPDKV2EmjGn3TcWZQ0AjLh
 sv4W0AH4r4KujeJUvdnSSJejjZJTNPG7qxT5ueCVfsjejaFnSUhYfrxZO370epuZlhRO5
 DLI8nT701zMRSJp5aFpUmWcFZob6b4TVko+JykptERLloOhQAV5ulWnhRi7QKLWgSm9Dj
 k4choCZxPAosWIE7wG/ZIMOEIrSxvpZpM6vAxVLhlxeO6wJPISvqa3Fp3yIYusb7TgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791965574;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=NP9pDWhX3KjcLWITXWO8GRNDDuYPuZ/iFYrrq2zkJrQ=;
 b=tANfeYEqwaDYg8DmAPPNrP2HJZ+fzxtvy5LjuojoL4dzKUc9Lwefw0CcQWtQBbVdrc4N
 wEFS2eCd/zfPHPehvd3Xf0d+UVkyf9XTsaDf0azx0b9nBEO0pU8GghuUnQ0GZEURDT8Ui
 Utell5JZViURpWQLlunpOlZVC7iy8TTkzETtrlMMVW2TwVSwEnB+ra4VaDBdQZbxpgAYF
 GU5HpOOzIqAoZNI7cjTRH4jLLjpC0LuqPAmGkXZ4DzhzoWAW3TrArKSHPDj+SiUlprhZB
 YMuU1CHVyrOz4IbB+v+6Qw77I+EVz3XIfZedREzLMfMKPjIbIZzE3mq6XmFsMg91bog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pDhkQthA; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=E9rplLO9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=rahul.pathak@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pDhkQthA; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=E9rplLO9
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F26140602
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:12:52 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E3XWJn2222162
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NP9pDWhX3KjcLWITXWO8GRNDDuYPuZ/iFYrrq2zkJrQ=; b=pDhkQthAORegGCob
 LODHuYRiNrz2XY97T8zPbbIDq/kSM9dHas87gRVO1nektt7U8kWZJxpQ+LAf5Pmj
 9PoeS10S5w4KfVM0ih7+lXAehQX3c3Up45wUX/jMe2uRmKxXkYvYtVjNeemn/+Fb
 GRJ83VWFkZnyli0iN6EPPbtYInD+tWEUkqomRt6BG6NR2LRYIM07qMDymbo5Ck8B
 t/V/P7HfA5+fYJ0j4o5cqhs4OeKHd8mnWbnLNvSpasiOeUnO0XER1dgcHuX4DCDH
 SN2eiKdokG2Tga6lb2y9K/UivkwxWT7Y65xGwhRblM6ZMOJMnwMQVA4n69BukKvv
 /Zov8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txsahtb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:12:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337f26ee19so115752011cf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 01:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791965571; cv=none;
 d=google.com; s=arc-20260327;
 b=Zbb1Ufn7w9bV+ZEgT4x8FhTBw71o2DWeVlVfbYl2u+1XztpghRpjtRK24pZ6yjcRL0
 2Od6YkqYy/OgXV5M38JQnrDKqjCoIYe0f0YbNf1pNeuH9lCDYMr7sltiRAcAS9JqG2Hu
 8lS7GeGnBp/Mc0HveYtu2YO7Ccvhm39gtlStKc35d8HexLsw2ltkbEPDR07I5spkr8ia
 UM4cYR+1sIjUfdE66lbtQTRbcNeLYM9NIeDRMcZ2mPDxKGCp6l4onrafnGueX889KF/t
 MtxDZw/0Gwsnpy74gdCoQw2MN8uq/1CwSrIr/SlM41OpRhADAq5ZYvnbP9WPkU5xiq4+
 vzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NP9pDWhX3KjcLWITXWO8GRNDDuYPuZ/iFYrrq2zkJrQ=;
 fh=0bsJK66C2Hv+5jvkD2BmEbPJPo+TVr5q0W+Y/Y2VARI=;
 b=g+oqT4W5guCX7CwZ/ovsGvW0uddcWFKu+htVx6TnVew90C8xbC6UVckU8MdHAxgZYD
 I+spk/KAyH9bvdqqDvAawCCpTBGhUTHWogfaTP7Kxzh02u+Hubp5SWJtURKHMvIwmpOL
 HI6CvA0uyGt1ITx0QIK0bUBoNR86Vo6cSP2t6973AUeGa3syhUVjCI8DF1Im6g24rXDi
 IWamrI7Y64hEi5Emci7B0QQgbBSdEsoUBnZLmKgsNFeqnP6MRyG5rHISxwASLp0CElrt
 nsauN7WitFXyg1JwUMz8ODxw02Cj/5g0NyiKP9svv/LXN7JYyO8Z+idoBpN01w+bBryM
 vECg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791965571; x=1792570371;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NP9pDWhX3KjcLWITXWO8GRNDDuYPuZ/iFYrrq2zkJrQ=;
 b=E9rplLO9OzY1KopL2oikZKurB0i+4MzyBXOzUt13EU3K0LBQjgtN0MwQBb+SWvykQD
 4dv9si0kM3SSmwffbqDmQRmNJZnVzmZHBHG8Tll1x99Chro2M7NcPu1gw/A1IWlF8VXx
 +n+S187PVV35L5yCI39jiu/MRRrRpsw4cG1g9ueJhhoTzdFzrgNEnotXYMqHyeSt5uzm
 pO5ppVIygmritzh3UjFK0WjBLkQr+ybcYZt7oBUdFowSwCWj4LC89UnFwq2qhjHT3Z/1
 m3lbozdj0MfLGN1PVCEJhLvp9sVbaGKq7+QMGdIL3rvt051HrDwaeRq1HGhWZLofeHdl
 Tr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791965571; x=1792570371;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NP9pDWhX3KjcLWITXWO8GRNDDuYPuZ/iFYrrq2zkJrQ=;
 b=wZubY0O5DNIQx8fjO2Qg6t32mdBfPs+uZ6tn0ct3VAogTe4b07BCaYuGl1ONFjyelQ
 Nn/dyPpr7KiXHZS8fOOMOjDrdTH8GD/64BXbro4rusNf9HLPawR+2juFK9hgUszVf+xp
 qap239Rj+tt8Iu9fgXCeHE5ReKnRPpaplfatGnCIV+FA6JJCiRmwZUnGEfchqG3poQNF
 LmhStDW6Yij4pDMf9pdnjpnUQXsKgynPTSZEBEoVaMNxRS04LOfZ0Mm6oT91XOvv0yIr
 s2/QlW9XYFwrUn1+wVHgiIqDWYazVYaLlkRPFh615ecBCPQQlnIm87x9UHCOJf9ruwqT
 K5cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhqp29cMO5w6trKKCyW1bisps+JbHviv0X4WvvJRFCKyk7G9Se4n8/Ch1/ae41X3sUPOzjU68=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIFuc+x1WtmBOHHywDVqGXVxWTr/w5lAYtmYFCtaGXcjeoZpO3V
 RkW3tlZEQv8NMmy7QLc/cOI9auOqC0TfOS78tbFp3+DkLIHKa85bsb+cALTBF/D4xD42lqQCHRB
 XH3rliOFgTl04bMXf0iLTNtxu5k6hsOmXgo5slZ0R1kcTfUmLvs31HhfDQeP/xMKDiOKPe+yinC
 md9iEjbApyau/PCCz/+PwBLgGiPuLJA2OuQr8F+dcrfDjHvg==
X-Gm-Gg: AYBFou2uHaIVNrnDPoNKN3aptoBK5tQsSM3pCzeliDW2RYStCWEQh0ncuYv4oabwOD0
 G/5UvUbCFhpN9lsmuh9tEbA5zE66mog2Vm8GAW7adhHLOYBMTstKkE2XLoeDzQlcrRhcCaJyqa7
 sivlLESz91o//orkJ3Sa0NTBpMp5G9jyIdaeRbnzCTzy3RchjQ6LIXD81rX0n/cPdmx1DKthEXz
 nRRN5jBr3isndDO
X-Received: by 2002:a05:622a:451:b0:535:bb7a:884a with SMTP id
 d75a77b69052e-535bb7a8df3mr186681211cf.19.1791965571172; 
 Wed, 14 Oct 2026 01:12:51 -0700 (PDT)
X-Received: by 2002:a05:622a:451:b0:535:bb7a:884a with SMTP id
 d75a77b69052e-535bb7a8df3mr186680861cf.19.1791965570571; Wed, 14 Oct 2026
 01:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260902141744.2422566-1-charles.perry@microchip.com>
 <cd52329c-e241-465f-a77e-588ae89f5f10@monstr.eu>
 <as1zWYeE7OGOZEmJ@MON-LT-C78453.mchp-main.com>
 <a83ccf7e-87ee-4c78-80d9-86dc0b246491@amd.com>
 <442ea702-451e-435a-8b04-543750e929e6@canonical.com>
 <99875a68-fe25-4fd6-b02a-7bb71c24fe0a@amd.com>
In-Reply-To: <99875a68-fe25-4fd6-b02a-7bb71c24fe0a@amd.com>
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:42:39 +0530
X-Gm-Features: AclHuK8N9fXL3e0n43UDZFiKxeszirfuJys0h_jqaWSaxDMvlhW6SdGkT6EqXgM
Message-ID: <CAFR3w36KKkJioAmZPeXBwDEErn9kPPv9FQ8QUY7EthY1+KxdGQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support for RPMI to U-Boot
To: Michal Simek <michal.simek@amd.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Paul Walmsley <pjw@kernel.org>, Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor@kernel.org>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@oss.nxp.com>,
 Charles Perry <charles.perry@microchip.com>,
 Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzMiBTYWx0ZWRfX4h8BYA+2143l
 u2FEUJk2qeSJrhn7+26Dsj6KZvAascafvoq6Mi3kfWO+LkCsbLPD/oQs9T+fO5mx9FKLBkIOqON
 zt4n/2cwmJhOfc1fT+OFWCd3E+ILsBfBCmzIZExlxNFPf2EuZ48x/3GfvrFdqUUpTY12CADX0YX
 YUvafRebDDvcnYfBtSGqtgUdhoim/Ab/+8Cbfgt5vd1DVnRpyoP0JQl7BZFCvmNag4zKd+IOWVE
 QOupHtFTuphKi3P0UMqAhiQVoeshHehGu3EOu3qK/iaHAhjld767g/rSUlwTEuRbUh48m4moQvc
 WsBCcRoABl+yttRU9eFuqHcKT6yYMSjD8pKzuKkEYDAo+QOGFxHqFP+Zm+dUAcWYezWKquQciLX
 o8LqMbpE6jOh2U456UmN2i7RPW8aTPyWZIgxCa+1MAsTajKyrRT6PAGXKFKCkeTniYj0mCyHowF
 ZGtORyFFKsiT5tO+A8Q==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6acf3984 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=1VxDqnHFAAAA:8
 a=p0m2OxuXIt7GWr_VhKoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzMiBTYWx0ZWRfX4J1JMxnLXVvL
 SSRVrlK7pS5zgp4ucxeLjuSHcm5ObwZ//F5EI+lPjWpyPkEibf6JN1vu71KRYhtLT+vVNWWMiI2
 4gCR4M3OJVhHgfRV3k1Th/kIKnqKZ3E=
X-Proofpoint-ORIG-GUID: 0vVZbH70H8GgGCiHJ1m1cBSLEIyX5yuK
X-Proofpoint-GUID: 0vVZbH70H8GgGCiHJ1m1cBSLEIyX5yuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1011 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140032
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

Hi Michal,

It is not correct to say that SCMI already exists and so RPMI is not
needed. If you read the RPMI specification you will find that the two
differ significantly. I don't mean overlapping names, but how things
are defined and implemented in the spec. Compare the transport,
compare the defined messages.

RPMI defines many service groups that have no counterpart in SCMI like
System MSI/System IRQ, TEE, RAS Agent, Management Mode, CPPC,
Logging, Request Forward and others. Together they cover use cases
ranging from typical systems to confidential computing and
virtualization, all in one specification.

There is also a difference in governance, which is visible from the
licences of the two specifications.

RPMI is under CC-BY 4 license which allows anyone to adapt it and share
modified versions with attribution, and changes are developed in
the open under RISC-V International. The development does not happen
behind closed door but rather any indivudial/organization can also take par=
t in
the discussions.

I think open source projects always give users/vendors freedom
to use any protocol which suits their platform. It must not be dictated
that everyone must stick to one interface.  As Heinrich pointed out that U-=
Boot
already supports alternatives for various things and
Linux and OpenSBI already support RPMI. Adding RPMI support to U-Boot
does not take anything away from SCMI.

Platforms that use SCMI can continue to do so, and platforms
built on RPMI get the support they need.

So RPMI is not another interface that does the same thing. It is a
broader specification, developed openly by the community that uses
it in which you and anyone can also take part.

Sorry for the big post.

Regards,
Rahul

On Wed, Oct 14, 2026 at 12:41=E2=80=AFPM Michal Simek <michal.simek@amd.com=
> wrote:
>
>
>
> On 10/13/26 12:33, Heinrich Schuchardt wrote:
> > On 10/13/26 08:49, Michal Simek wrote:
> >>
> >>
> >> On 10/13/26 01:55, Charles Perry wrote:
> >>> On Mon, Oct 12, 2026 at 11:47:51AM +0200, Michal Simek wrote:
> >>>> Hi, +Paul
> >>>
> >>> Hello Michal,
> >>>
> >>>>
> >>>> first of all do not use mailing list on denx.de.
> >>>
> >>> Ok, I sent this series at around the time U-Boot changed to
> >>> u-boot@lists.u-boot-project.org. Sorry for that.
> >>>
> >>>>
> >>>> On 9/2/26 16:17, Charles Perry wrote:
> >>>>> Hello,
> >>>>>
> >>>>> This series adds support for RISC-V Platform Management Interface (=
RPMI) to
> >>>>> U-Boot. RPMI is an OS-agnostic protocol for communication between a=
n
> >>>>> Application Processor (AP) and a Platform Microcontroller (PuC) [1]=
. The
> >>>>> goals and purpose of RPMI are similar to ARM's SCMI.
> >>>> I have raised my concern at riscv minisummit at LPC and also talked =
to Paul
> >>>> (riscv kernel maintainer) that this is not the right way to go. We a=
lready
> >>>> have SCMI and there is no reason to introduce RPMI when it is said i=
t is
> >>>> serving the same purpose.
> >>>
> >>> Cool! Thanks for bringing this topic to LPC!
> >>>
> >>> That being said, I don't understand why we can't have both SCMI and R=
PMI.
> >>> For sure its more code to maintain, but there are other things at pla=
y than
> >>> just the functionnality. We discussed this in v2 [1], the points of
> >>> contention were:
> >>>
> >>>   * Anup said that the main blocker for him is that the SCMI spec is =
not
> >>>     community driven while RPMI is.
> >>
> >> Based on my information none really starts to talk to ARM about SCMI a=
nd this
> >> has been introduced serving the same purpose. None should introduce an=
other
> >> interface which does the same thing. That never was the right way to g=
o.
> >>
> >> Thanks,
> >> Michal
> >
> > Hello Michal,
> >
> > RPMI is already used in the Linux kernel since 2025.
> >
> > U-Boot has already lot of alternative interfaces implemented:
> >
> > * Xen and QEMU/KVM
> > * half a dozen file systems
> > * MBR and GPT
> > * FIT images and UEFI
> >
> > I can't see anything special about RPMI.
> >
> > As nobody, including you, seems to be interested in driving a discussio=
n with
> > ARM which would set back RISC-V for months or years, we should proceed
> > implementing what is needed.
> When I found it I have raised this concern with ARM too.
>
> I have also sent one patch
> https://lore.kernel.org/all/d7f7e8c9589d937b60e43168845ab4fda15037a3.1783=
603600.git.michal.simek@amd.com/
>
> and based on my discussions at LPC/OSSE I will send another version.
>
> Thanks,
> Michal
