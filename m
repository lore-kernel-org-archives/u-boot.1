Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCCBCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B63B40755;
	Mon, 19 Oct 2026 10:27:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOOhLtG5zAVo; Mon, 19 Oct 2026 10:27:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97794406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405673;
	b=AKGcET4kfXJ5NM8idtP09f1nGGLsAwV+F4V1H6XgqMYVB9FMGl8H/EeGc5pYZkeaclx3
	 LdB2tgBMnEDOLyWaJd6ztKzT0L8T5fcY3DWNlhfDdhWoX8YGzRlTAH9EokPNbOKJ1AihY
	 BJSGVyTvCYlxypVSaG6jspaaKjoG5dWLUsyFbmJwMWVz+NnANfBEwXcbN+6LnC9BjHtjZ
	 eNiEJtHkDgbSQoCV3mtCB9pz4kh4CMOYsW6azSLtcI0I0eL2kIDnGbZ1Gu5reM5ZYQ3cC
	 7gJO6wSeYxVA5z1rwJ0Uax0PPZlNLfq3trs4A6QmPhnHoUIPx+fjlI2H01dmigi+vwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792405673;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ULrFvNrGoCscQN5hY0YZfaO3xJBLB2NRTgBC66v5le4=;
	b=RMjDs0r8pWyQV3FUaxYP8POrJWiEr/qxxGZ3cYHc3CRPuAaOv93Q2cBfMPvLnaPEanIM
	 fujwg/771jUUcxqyT2NLMpVETUkqNvgntIMfl0YdtQTKNGpwoZnqESBG7UdoDvObcDe6D
	 z+ZFW4Z0bfC7ZFPVKWZA3esjyeLDMkygTT/1OfiZ+xWrLUrptDcMs/YLlgDh9fQYAOQDQ
	 FJX7wme+7Y97JEJOcg4upi8lqPt1PIl4qjThl9Xzm/T77g+zcbOHGpjwxF5+iJQT1HHMy
	 yFZxtXSLY6rzHJpkCtKIcNOeb/ySBlF8ifH/6qVFAAAvSDt7r4I5Qk+pUgAEjmFhKjA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X7f3Yn4R;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V1RkDjh+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792405673;
	bh=ULrFvNrGoCscQN5hY0YZfaO3xJBLB2NRTgBC66v5le4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nbATO0C7TjHr9buPvDXgrzdJJL5CHyHR4z2fE1NKo8VnR+5RVzHnesUCumbm4n0I3
	 MwMe1sawegizAcxB32Fh28o9OgxYTH1IUi6OKdPHXb7d3/nNWYFRFLTTymNFhrZTbl
	 FNpsQSvlIbrH/XhxOQu/+5UD86HF3SYqahog8blg0dcHx6T/ULvQ+wmxxy8RwJA1V6
	 W4p8SGEM/g1JPbDQqcw4vu/pZU8tiaNAFqx1n4Yr+AtL40i10aT1j67xjEKzl6V/vv
	 lK8QsfnTATMmmjWCy8ZZx3mk4/NhzarWD5mxm2g7XMLLsaC/G8L3yUZkJuNctQtf/0
	 0NyA6DWexCK3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97794406C7;
	Mon, 19 Oct 2026 10:27:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4822C1E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45C12406FC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKiyCyEcvD9d for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:27:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75EC5406AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792405671;
 b=XURy1ZEOqW8lvIPuF9V8aA5JcLCjOv3fVR18PdHnyZgujKWasTPeQxo8pSA1J97hVFPD
 IsCIvd65J35nlJy60iVQ1vvy/CNamx07C+vCETuUhK7kSl9IY6KX67DNNnVrtXP5IS6tx
 +/FmJw06kJ/7jpuYAwP8tK4+xA/f7p0HF8gcwzkXJS6bQlmK4/P4P/zf1Tj2ESlawjA2U
 9qlKTPmbgbwUKRJYksfqRNmjDOBadw5Wyeh984/hy15KSgv520j+9OAcZksUPrLYp3xUh
 TZXtYlunGkk/caD1AdifzixDDzd41isC1g/5Hp+fJytKSTfUXA1+cH7tBu7ovJ4KvaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792405671;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ULrFvNrGoCscQN5hY0YZfaO3xJBLB2NRTgBC66v5le4=;
 b=HVOS8indi/jjZsBFnI4EfzFcwmLIdslhGsIORw60NgsF17/HnKbYzR+/USBFBDtwsFyg
 yLPmBd6394+w8toCXL50bz/YdpUmp2NDtlclStf7dot4lQPLGXtA+1ji5ZzYaFWH9kPGs
 hARpVqGzKh7DVuo/JG/YzQjDC/OdGH63D02cnXt+R78wsSWJHnme/hLaBagIz/sKl8NpY
 WiAqO+CvBT5eH4AIbI0tPRlfTlKnv1hfZMxjFkxRru/oIJdoDLAgEkTvLbGrH7IQWU1b1
 WT8G9Jix0tF/2UxjZW80lf7A906E3F/KbG3WDIIZaMGI8UyI6A3TlEL4jkNclo2Hutw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=X7f3Yn4R; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V1RkDjh+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=X7f3Yn4R; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V1RkDjh+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75EC5406AC
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:50 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OtB5723142
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ULrFvNrGoCscQN5hY0YZfaO3xJBLB2NRTgBC66v5le4=; b=X7f3Yn4RUUBxys7q
 vzcm/3hzqxEHRo7rNDAirPBaEKTO2+YDE90Alme7VzrWVkBOWqr+kIQYRLzt6FSm
 h3uQ8/G+0cKtb6SFE4amH7sgMt8g675rEgv/lgWsAiVCKL92E2U/ZBD29Ue5wBSC
 cPyb11eGBQGYRinvNQXLlVA45CgJqIIUZTWaBrFuLOBasKXiJHfx/e6M9D0GY0Jg
 2UUSxEEAcUaJAAiXaNy5UhRFVT4Q2WxNge1bnjHBp4jmO+DTSD1x79dbotCPCHNG
 t5Ozq7doWgzICWEHGQ4ryVCmIutpZuSzeZTazOS44K4Tfg5XmnbNkhhTOICDIfHo
 2tZTcw==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65gkf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:27:50 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6713ebbca2dso2427609d50.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 03:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405669; cv=none;
 d=google.com; s=arc-20260327;
 b=cJE89wxOxmxmQuaBKZ6YnYuiM7p9qkIqs4o9fatzxOP4GYWBCmbsMOh7S6mXJwA0nK
 Gk7kcpDpjfIPuWVx7P41MelR4Cj7UrI5pWM9J1CCBcKZXPezuhbU20OzxbYSMKVT1oWd
 zi33OGC0tcIS/f9G722SLZg90BMs0Kg82vw+KocMUUbE6DglvTmAkWTFQ0xjwPlioSCB
 RIONE4bG4GPgtO9Vwmx5+q11Q6V26OKb8hOBEIfmXy+zBvdVbP0zI3OLkVlE3/C5Uiol
 IJqXNzzwepzIWvjOi4klgoPvFKhquok5UlnUOPh1g1vFA/eyy8XIoGYrfngoB9H0/Cfr
 2/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ULrFvNrGoCscQN5hY0YZfaO3xJBLB2NRTgBC66v5le4=;
 fh=y9CpJ7zLdah1JzbKC6bvaKW/NdEJJUyqB+/AH8//8Wk=;
 b=QfB2e98tklwXjPVMSZnVAg5TkFrGvqZugAOqQS8PT5IZ9179tsjNUdxKzOe+Nt9+i9
 nX1xym73j3oqOO32KsqVJLV1BVpmSGsCYb6VYaw0T8/FMQEpjxkquj+OMYau6CMxSk57
 kSATzfF5D8cgEz+n5M2cvYKEP7yAgGFgVaSaO8c6WPhM0BD7Jxj/BPm5qtnwI1vAUeiB
 Xz2nbdZVoRhN3todGDBSUXo3EfPT4GXM/1PZW9mCzF4ayPT/JNULEP9r1Xj0oQldJom2
 I/WugwXWjdqAdwxjoWoyecM+/QhR+A4ZPJdfO6e4E72Y4lUCsBeBfikKtuGSSLyKyB1Q
 pCsQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792405669; x=1793010469;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ULrFvNrGoCscQN5hY0YZfaO3xJBLB2NRTgBC66v5le4=;
 b=V1RkDjh+uMcLabiUbXgQ80tYjkPsPqwdECcyANl8qgj+G9vFBISt1HDaYpCn1QQ9a3
 1vww/Ac5yE2jXbNOol+2+fDbELmgyIDzpim8xjOVu0/G6Y/76XmHrKXVvgpOvxRGu63m
 4Ed0u3avvOjzjoZIPQn7EnSbUYfc6949RJm/Nj8cWfXp6x4SUunFNAGnzomNuAgkXR7Q
 JUm1WW2j39Fkx3Jr61EdTdXEuxnNkqnI/qZw3M832U0YhT7xCwriXIHKrHTVCMK3l6yy
 UymRRjrgYZwJTctCB/1AvI/xz77iRck1X9yHTppC9nM0kYEnsENh6jmumfHubZaefyAz
 YJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405669; x=1793010469;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ULrFvNrGoCscQN5hY0YZfaO3xJBLB2NRTgBC66v5le4=;
 b=u7reaRAK39ofpxByVaKuvIkPPdVgw8t0h9K8lfV+mwo1WjR4r5lqIEsJnI96LsZVpE
 fdO58kVP0UgxQsmBBihN95XIyyG6t/wtsPeA5yVaHb5v+lS6GNV3guaV+Xqi5GL9LgNQ
 F+EsUdx0of6q+Gwkd2iXeemAemO2E+LZAtrj3IqwKqzlEeEOPC5PN9cSHQ2zWAdr6+Xn
 XmOA8wwCpt6ztHa8pfkEBfhvlHOM9La4ZwXiJHBKslhgxZgmt+khxlA/l4cjeWfPcKJd
 JB9Y+rJlEiIzIFFG68ccW5Y7IGm65I1xEFS9GIVD9p2lScpEpHVxqMwEDMFl5EQy6gw/
 Bfhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT4vxLjZFg7cnrpbPsvrW48y/8PxZw+eNglEt32qXz2psrehP2HfG1pTElB+XQ2IjMEPH0nxk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ+rM9RSOojvt4iZOI/z2g4cZ9yAdpNIilIq5SlwTTdlEQS2zko
 mgFwrnuL3RuzFzBoLS6U+oHsg0tQDWrCCOKJkyGKt/3EGyKDd2Kc6YFYOUMfx+2hafUZixV3Utt
 z2Ri4QVtq7H5LE3GsSbtnXNp0Xj2B5WNLKJAPzfChRILFoFm/ZNU1EKxLxTcn9nSvJ0BnH0AWOA
 pLE5c7Y3MiUs5ciNyAEYjB73RC3D+cORLV/KuSLVHPduJdYg==
X-Gm-Gg: AYBFou1OnibOv+fxFNy4sGnGziAVTd/HX0MZQGrTtR6lcDqNEWtQS3UCstJgFkB3h7w
 zOgNeRhFCq8W1wWhMry7TZ1C1ietuda1s5qYB5OfGuCgim4RDoYn7IhgyCqw4DsNcUR0PoKdHs5
 VVTGfDPs5ncUSsQSCOYgOSc3tmwctAU2R2ntT1us6YXAy6LQtK4qAO0QhDGw==
X-Received: by 2002:a05:690e:1186:b0:679:8eb0:c689 with SMTP id
 956f58d0204a3-679ca91b098mr1726301d50.123.1792405669308; 
 Mon, 19 Oct 2026 03:27:49 -0700 (PDT)
X-Received: by 2002:a05:690e:1186:b0:679:8eb0:c689 with SMTP id
 956f58d0204a3-679ca91b098mr1726298d50.123.1792405668853; Mon, 19 Oct 2026
 03:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-4-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-4-9e5b82644359@kernel.org>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:27:37 +0200
X-Gm-Features: AclHuK8klfSohSXUMoaL3wE5s_rMzX8v4fIL4WXHbzpj6NrIkcLQDe7Yn4GUNpQ
Message-ID: <CAPzfCAbSJwPB2hCr89wv73z7izwtwLyozMF_-HaBt0LUJKi16g@mail.gmail.com>
Subject: Re: [PATCH 04/10] test/py: android: Use for loop to create the images
 / update disks
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org,
 Jan Kehren <jan.kehren@emteria.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX1qjQ6psxXI8Q
 /p5KbGzRufByEn85HUmZku7HFjBvlfCnkFM/aOCfJ1QfMNDfbuRuQc/Asi5wfvPbympKM09wSSh
 3sVzg6iwO4gpOO9ir9FFIHW0km57wU4=
X-Proofpoint-ORIG-GUID: ctCjbVMtNIiutT0gs4Hn5BrarHDi_n7V
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad5f0a6 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1LsYVejWIwqCgaWe8gMA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MSBTYWx0ZWRfX+KLSIvV0gukU
 BRPaRhV31cZP0HCdy55pnh1kHg/WW0zMZIjiS7cjh6TwlCoq3dgLrmTzXaDWaARq3yjlTppwGfZ
 BsMee/3p3iOX94cnEE0tXlJwS+FtuVjnmi4U5RIBj9oUiwbCleNXZwUwGBazcJv5C4ntZzusGhJ
 hBIneIskJKv/1GNmkwaHWWXD0SqUhrDQp6g9+Tx9fRc2GXCQRsUSTa2C5+GzC9PrwVVCPRIjYUD
 RKuGJzDfSyRM5N7gluFjRmithDKqMrXV2MuzQrV0+DtcXv/xH9OaU5M8GAjo8uueJVpKc0Inxpy
 b4GLL66rp3uC5xcBwR+DuvFAsAl4BqZfJjWCGnTW42zeIsgq+ydRcSYoaYU3cO0VRBt9qe71biS
 TwvM1GS9aor8WWqMxjdSKfAAMXl3Ju/+zhidDR0IisP2+cg7SLt2RfoDwcvfqDBSa4wAk0k24kX
 6ZM7HGQH4Vv/ki2zXoQ==
X-Proofpoint-GUID: ctCjbVMtNIiutT0gs4Hn5BrarHDi_n7V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190041
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
> setup_android_image() creates 2 mmcX.img files:
>
> * mmc7.img: For boot image v4 support
> * mmc8.img: For boot image v2 support
>
> There is quite some code that's common for both images. Currently,
> most code is duplicated.
>
> To prepare a cleaner refactoring, move the image descriptions into an
> array and create each partition using a loop.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> ---
>  test/py/tests/test_android/android_image.py | 48 +++++++++++++----------=
------
>  1 file changed, 21 insertions(+), 27 deletions(-)
>
> diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/=
test_android/android_image.py
> index 8b536754656e..14dfd26fffd8 100644
> --- a/test/py/tests/test_android/android_image.py
> +++ b/test/py/tests/test_android/android_image.py
> @@ -13,20 +13,6 @@ def setup_android_image(ubman):
>      parts =3D {}
>      disk_data =3D None
>
> -    def set_part_data(partnum, data):
> -        """Set the contents of a disk partition
> -
> -        This updates disk_data by putting data in the right place
> -
> -        Args:
> -            partnum (int): Partition number to set
> -            data (bytes): Data for that partition
> -        """
> -        nonlocal disk_data
> -
> -        start =3D parts[partnum].start * sect_size
> -        disk_data =3D disk_data[:start] + data + disk_data[start + len(d=
ata):]
> -
>      mmc_dev =3D 7
>      fname =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
>      utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
> @@ -68,15 +54,17 @@ def setup_android_image(ubman):
>      with open(fname, 'rb') as inf:
>          disk_data =3D inf.read()
>
> -    test_abootimg.AbootimgTestDiskImage(ubman, 'bootv4.img', test_abooti=
mg.boot_img_hex)
> -    boot_img =3D os.path.join(ubman.config.result_dir, 'bootv4.img')
> -    with open(boot_img, 'rb') as inf:
> -        set_part_data(2, inf.read())
> -
> -    test_abootimg.AbootimgTestDiskImage(ubman, 'vendor_boot.img', test_a=
bootimg.vboot_img_hex)
> -    vendor_boot_img =3D os.path.join(ubman.config.result_dir, 'vendor_bo=
ot.img')
> -    with open(vendor_boot_img, 'rb') as inf:
> -        set_part_data(4, inf.read())
> +    images =3D [
> +        (2, 'bootv4.img', test_abootimg.boot_img_hex),
> +        (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
> +    ]
> +    for partnum, img_name, hex_data in images:
> +        test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
> +        img_path =3D os.path.join(ubman.config.result_dir, img_name)
> +        with open(img_path, 'rb') as inf:
> +            data =3D inf.read()
> +        start =3D parts[partnum].start * sect_size
> +        disk_data =3D disk_data[:start] + data + disk_data[start + len(d=
ata):]
>
>      with open(fname, 'wb') as outf:
>          outf.write(disk_data)
> @@ -120,10 +108,16 @@ def setup_android_image(ubman):
>      with open(fname, 'rb') as inf:
>          disk_data =3D inf.read()
>
> -    test_abootimg.AbootimgTestDiskImage(ubman, 'boot.img', test_abootimg=
.img_hex)
> -    boot_img =3D os.path.join(ubman.config.result_dir, 'boot.img')
> -    with open(boot_img, 'rb') as inf:
> -        set_part_data(2, inf.read())
> +    images =3D [
> +        (2, 'boot.img', test_abootimg.img_hex),
> +    ]
> +    for partnum, img_name, hex_data in images:
> +        test_abootimg.AbootimgTestDiskImage(ubman, img_name, hex_data)
> +        img_path =3D os.path.join(ubman.config.result_dir, img_name)
> +        with open(img_path, 'rb') as inf:
> +            data =3D inf.read()
> +        start =3D parts[partnum].start * sect_size
> +        disk_data =3D disk_data[:start] + data + disk_data[start + len(d=
ata):]
>
>      with open(fname, 'wb') as outf:
>          outf.write(disk_data)
>
> --
> 2.56.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
