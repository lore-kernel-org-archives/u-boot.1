Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F505CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAF9F406AC;
	Mon, 19 Oct 2026 10:27:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l1qDpqyvmrgZ; Mon, 19 Oct 2026 10:27:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 211D8406BE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405624;
	b=Pb0lnvXQSc/6VcQkJ60APsVFo90skH3u4BTyL+nAMBckzexdIEtEYPEpCwZ11rcOqMhh
	 oMJ3MBTAtyKl3ZkB0QzcgmN871bUBBQshqbPSa1OKy2gL8KSNgBy85tWNKUI/30erF76o
	 aq3griqzRFTYHco5n73dCVGbRTRh25sIF2crkWaVMbB8pO2kzbAyDu2cuH8wIhjH6Eyrm
	 GYTbjeCvYWQfK0AZ89P3ikvGc2SfF8HDzr+M9GdcQqC2zI1/5mpVsFjM+MIJFZUo1IXYt
	 xura0MGcOi4L6AvI6xw5PgfHjQOjevsTkJjcy9Xp3FeVaTvNVkmX/ByczAGs/vu2YAg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ig5gVN4EYgO6k9ajpC+FDLhR+O0gx5bGBZOTYCiJ0Y8=;
	b=mrNUrzz96y0niqxmkOQeNMXWUao9obWXfE52ncObYeSd0Vql5ITFMpIFhP7F7lhZZiFN
	 SLCg6KnE0QgHrK8WclYFvYorosL9wD2Eo5dYwEBwrLwnbQ1NLfA6eKxz1blJASG0C/Bpm
	 6vsH7l90ruN3GaaCppPqyRHIKmMLsolFjWTmIweVDFYMKhIUta2T521/Sl0cNIMgoNkKE
	 Ajn40WAq5KlE9R1DJdnbuhv6NThYRJG6/MM2FLbBei1UUw3nzeoPhxq9j7rqb4z8rDNGI
	 iaRQuOYyigqzPiiZXLSjfhVaxZgWxSgnZ9I4cDZLWyoTru0cQFNKNrDXaprLD+Mh/RQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jnim63BN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QJ8Uegpv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405624;
	bh=ig5gVN4EYgO6k9ajpC+FDLhR+O0gx5bGBZOTYCiJ0Y8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YtQ1+nUWC48Ksj396YJdPwPgm8/etmR4p1LM/ZgYQCU5IDKW1kYeHopPOt1+KPeDP
	 si/8uqDPr8IIjIuXxZOvVodp6Tduv1dIkXRRo97EcW4C7Thr6KYMZX2hDgmXyNYBXG
	 4c3UGluw6KbZUvgns+TCfFKUW+qbISGGYQVRcFM95Aoi/q7ZDnvuEhi5XbBv7TwnS8
	 zv9zwsnB3+Oa9FQKdWJTBmoWmvJANicRQ4G8pA1wf+BBOpq+jjkJIitQRf+jmn0mX4
	 to77u3OwH/kXX7rRig6FaLOCSnqj4/KfnfnCGEZkXSwJTKKb0Vmxa7YP0+GU4XNnMm
	 e7x3MP6Gr/I6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 211D8406BE;
	Mon, 19 Oct 2026 10:27:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A799523F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D78D406BE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqRDpAIAzM5U for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:27:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA6F5406AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405622;
 b=HOLIrQX0pcdgwuI9NOz5lrYcqUJiW6B1iqmVfCy6F/OZGCnnS8tDxISIe+M6JPpjjdqK
 A1xJhKRa6V9LNBMHnObSUKV+vF44tct5WEIw+65BPRXFviaeyNc3I3Wdv1nMEOJikhHdV
 yMFRyWyxxtsy5z2ZfFYhfLf6YEzvs9pvCUiaPTkSY7wIjfTUb1TRNju/qbANvNmXXItqu
 fRzbKaIRpWvPRUfLqBz26SP2Me4p9WCJ4iKBEBlvi92HUzRquBAv7GH5/233id6nvdBAM
 Fr6LW9WLWmpnE2rl2AMGTPUrQ2t3mPNCQsf9sLfnK53NcalBQgifY6seV/38datlGZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405622;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=ig5gVN4EYgO6k9ajpC+FDLhR+O0gx5bGBZOTYCiJ0Y8=;
 b=GLN4qBZwgAfHciQLMSJmCqUVvfEzVU95bf20D/2lfBU8rKBcO8Y+ukfu5B5/RcCrEb4r
 aV1rC7wupp+hsHrt3H4t5HQpro5mar/dK8mPisCh0TjCNuDYLy8GOxpBrgn2Koo8jf+rY
 6QH2N3bHcyNnRgQ5KgYyhVNQfDcm2u9HEHw8izd9tyGzFz/oWG0n36mMONYHRyOreLuGH
 eK5StWRtBR/CxGTS7pp0BejHF4jaHKX3p40Wt7yoQnwVXz7y7dfK3Lrrn1kUJ40Az2hm0
 2JTNj7lAaSjUlI9XMUjR4FlGtfM99MSWUeTUv8Yqkmtu5xTo7/hjBPO20goxAAj65Kg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Jnim63BN; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QJ8Uegpv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Jnim63BN; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=QJ8Uegpv
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA6F5406AC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Orou2234322
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ig5gVN4EYgO6k9ajpC+FDLhR+O0gx5bGBZOTYCiJ0Y8=; b=Jnim63BNUb8B5uHN
 0ZYXKJ4xL9Lf1vhvf8oK8dJ4Z8EOBpX9aOKs5tTkIaBa8PAfWEHWm9OI0nwGrPfy
 DgWa/5aKxZmuKn5Ih6apfZvDIAwRqDMCzUkexPy5GQUqqd8ysN4tYV1vdbqf4saI
 PPuFiYp45hby3j/rhWGZw1Z9XPNGfVeWN/3wL0ENTxbZ4g7/W21kD9ch0rV04qPn
 Vv1F+qPwB5JzoXrKTGgdnCFG85ywVOwmD2Q0l3yx1aIa14rzq19Qtb9cjyLw34G5
 I46ccDOomq+KQAtHMOMIDvDaz5sOmv2/vWW+bWzSJP0jdHFtk2Mu6tJmI3tocoQc
 uitLfw==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x8mfj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:26:59 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67686ccd1b6so2513567d50.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:26:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405619; cv=none;
 d=google.com; s=arc-20260327;
 b=m9yytKItB+Rb7XBj2rem3dRd4N638nvAR9pp3Zok+xNhAJTvFV32iEox3+KXwh4vhG
 VXNSS5Z9UZeJ7tCoZ016KAvQARwkjhIMIqJi6fn9g/c7SlHx/JexJcrBs9n1ib4yiQ00
 y78SaTz3wNmDr8Y3fgsMRZsX5dIZhxzE4ejWKxcV5IB5TlfaesBVe6I4VklmiP9EDaO3
 1CxCxwyjRFQJNJELvb8J8i2TUkMafhXGY4Xc/G39R4eDdJFkk1cT2pHjs10lhtp9057v
 ImfQhJPz2sSNyvHhwDTGTcxQnKyvn3kFBTZy2er0PLPGSrZyhQTdkcPL0NVvt2jyCnj8
 NVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ig5gVN4EYgO6k9ajpC+FDLhR+O0gx5bGBZOTYCiJ0Y8=;
 fh=d7kpg8Ybnk8C8W2IgAXYVN2kV5AAT6eZI+GSb3pkxdE=;
 b=cTpeiqjYEnuLvgLA4mWFojDNlnOSNOId8fajmAwpINNuhCF5ucLSgUT9Q5O63ODXPu
 7STn2F3HXMwR8eAVyL8KELQ12jic2Qlb2VLCO85ynptZC9KLH5PEyCnrcOvOSdY9hC2o
 CCXm07KT2d717p52IlPi30VtxzkskslkDFRiAOmhg3uKEXnFEuo9B2zqaqG5In57uOSo
 DFPNFB0jM1BAWAWSnZKq617emcpvEPM9+YJVcfLGnSTD2zjGY9lMv25vIdHMOR9DASS/
 t650L0tqD0RpZLdoGO1nA6GkOoWJRq6u3Sz0ltQjnMcu0L3NQlJ+NzV1LCf3uh83VP8/
 S2vQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405619; x=1793010419;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ig5gVN4EYgO6k9ajpC+FDLhR+O0gx5bGBZOTYCiJ0Y8=;
 b=QJ8UegpvfmtPkZcPHBNP8RcJIOOd/Iwon4KX8wLwnBZJLa37XFWGIoKrzb63PFXo39
 qtLHvnZ8kqZg9iqor4psHth9LTepnX+CwBkwI6bVWhOvmCwrsxPTiu509pPm2XQRMAhi
 FkvRe0ZGLzIUcL1IBgn26f9kyUxvH0A0Y23F0yhIuK29GsMbrk2XlAuutYVEXuexhTf3
 BvV0BXZ7kiNAT1B+8gUlLte/1hS9t9rWSgGVaezh4YynNwqH9QZYYuAJYJAPxHTavmnk
 /UjEqtKB/j9BbJpIn3pvpimuwl5GSsmiBy+VgzdyEV2Mc0BpcbUXKZDNL4Wux+gjCs8+
 Bpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405619; x=1793010419;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ig5gVN4EYgO6k9ajpC+FDLhR+O0gx5bGBZOTYCiJ0Y8=;
 b=DGgWutNqweY8UO6rIHeiJ2m0Q/WN+mW7OKCfoFF6jTXoG1pGLox0RDzarV1kyqkQXJ
 2n3yI9iZ05Xk0Y2zreM+nQu3etXGVpKnPOVKHnJluc5/TsJ5680Ek8ASEYlJlEUYq6I5
 32kYjDDCj731HxFp/WzWAgb1QhOSh81vL3VjZ6JT6ccWSvt7xllFXFuwaZMLmQdSmxHp
 XGwAIH+dm2NritjB2wBfBovalVQV5gGr0veKkqo6ssLBHjVNHm+KUf/JjSnzAR+J5yf7
 mKbErehyBgmN3yhyqoCUYnuF2K9T+11nMmn6d9VXNd52RxfW0hNsHWgi0ELdoCtTafzw
 9Tgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8i8koT0fEKt5eByYlS+NMgjY+uBZzmG49sjrKecd1Pn/XUEb5COs5BMOklgAVZP6uRSr7mHw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIZnmbNaBWbJRE8kKrAG/kvAt53wLHmSezrEy0VoEKUDGtcthQr
 K1CMcxT2ZtVwqa6VfKux8VgEzshs1PsGkMt6yx+vPVk45XEl3f7JJS7CLirVO4lfalR79YeUIhk
 vrqp9o1u3Evm1IzxzCUENJjp0PF6T02EUtyKGFUdLfQ8ncGzVWeE2kHXaqtCnSCEFTppNDvsE+p
 LXcx0qJRDOrXPuy135gFxJD2a4CU8CtWRwKXgYOR+bhNzE/A==
X-Gm-Gg: AYBFou35PyhWf/M5DNXJjVXhI8CPSIQw1OWAjvUofl0U63dF7Ju/FolEYqW92giYWC4
 /D71UdVLpwN8xD5dKs4PJdgGlt+n/Jfgow/CuyAmXr/7LpJToh6zWO8NwRbs+jlkB9ytR7cJiuY
 mM5yaUHHpcAWhcfCIL539KUdCnb30SM/zr+JvVYyeRD5gwRI4G3EIvrrcWtw==
X-Received: by 2002:a53:d017:0:b0:679:b85e:e0b5 with SMTP id
 956f58d0204a3-679ca7343f5mr1686894d50.33.1792405618668; 
 Mon, 19 Oct 2026 03:26:58 -0700 (PDT)
X-Received: by 2002:a53:d017:0:b0:679:b85e:e0b5 with SMTP id
 956f58d0204a3-679ca7343f5mr1686889d50.33.1792405618293; Mon, 19 Oct 2026
 03:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-1-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-1-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:26:47 +0200
X-Gm-Features: AclHuK-ywtmUhFOOPGBsohmUCcyWlhpWtUgHdbCjtRlZGn_iA4twTb6QQ2bsnsQ
Message-ID: <CAPzfCAY1vcrJqhmT5wwgAk9R_5=2yY7O=-BQn6u4sG8vHcB3ng@mail.gmail.com>
Subject: Re: [PATCH 01/10] avb: Use map_to_sysmem() for flush_cache() address
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: NWp1JsCooaFYs4Tg7JInM7y1aKd_IeGk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX9ESgt3f9/xsc
 NmA0DH5YBOkzsi/oApH35ychigZGg+XfBUWnIrokmxDmEIuk3wggMNbXhDdWFwbmfIWq22C3giU
 c8dkMNycEv9mUIFFtlkbhvcYJ+1e760=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad5f073 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=qs53BbIT1MIF6wlRWpoA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-GUID: NWp1JsCooaFYs4Tg7JInM7y1aKd_IeGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfXzSNgoujmWee2
 A2MevjxzKbwmLZ0NcMu70WGeaVWFwm9nDgxMO1l3Y8BEUkT1d5gNOvd8NyM2XvmSSJZVMI/UqBA
 Z0MWxuioXWwdp7JwGclcvJDXqnVwm0jFD5ZEa3Vuel5SXNJoq++301Rva7o9bWloTsclJxSbkI3
 nBlcJafK/7qAj5MAsk3idADWIJ+o6kmd8Ujb8az0Vg9uYvPOczVkRLKG6864RWvzTe9IHnH7214
 UdlRACg+L43atoJLHnW1uX4x4ETamWOGkaNmv9+islnoSu0PNFhlOE8RFWUh/JDEBNPmhTaal6k
 ONGxjtDWcAbJxsLMijyQgKZiqxyxDDubfO0M/HuLpv0mD+X/rUvNhNYcZTU6hFJhco09cRHsMHn
 Y2qXCkbs2F8FuDdqh6CcwCxohnTKvm1Z09aAnTSk41V3zvXfFSzt0zS7q9CmKULyBIOTsAMUeuL
 F0smXHIXR7qeE9cXmaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190041
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

Hi Mattijs,

On Thu, Oct 15, 2026 at 3:55=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> flush_cache() expects a U-Boot physical address, but avb_verify's
> mmc_read_and_flush() passes a raw pointer cast to ulong.
> On sandbox, host heap pointers (e.g. 0x1a27ee70) can be outside the
> emulated SDRAM region (0x0 to gd->ram_size), causing map_sysmem()
> inside flush_cache() to crash:
>
>   phys_to_virt: Cannot map sandbox address 1a27ee70
>     (SDRAM from 0 to 10000000)
>
> Fix the crash by using map_to_sysmem() to convert the buffer
> pointer to a proper U-Boot address.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  common/avb_verify.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index 09f1534c3cc5..d157adc4af07 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -7,6 +7,7 @@
>  #include <blk.h>
>  #include <cpu_func.h>
>  #include <image.h>
> +#include <mapmem.h>
>  #include <malloc.h>
>  #include <part.h>
>  #include <tee.h>
> @@ -346,7 +347,7 @@ static unsigned long mmc_read_and_flush(struct mmc_pa=
rt *part,
>         blks =3D blk_dread(part->mmc_blk,
>                          start, sectors, tmp_buf);
>         /* flush cache after read */
> -       flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
> +       flush_cache(map_to_sysmem(tmp_buf), sectors * part->info.blksz);
>
>         if (unaligned)
>                 memcpy(buffer, tmp_buf, sectors * part->info.blksz);
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
