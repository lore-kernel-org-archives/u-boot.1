Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B74CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 18:23:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCFAD60600;
	Mon, 12 Oct 2026 18:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7D18lUGcIcZ; Mon, 12 Oct 2026 18:23:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8901E605CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791829433;
	b=V8M7zPK5UHJvJAJALkkK0IQ0xsUeLKZN46V5h3cr7oHWnee0HqvStkVzrn+12V+U9v8K
	 UTySShJBdsbz61zjWucZTB0eacvRp0tNXvEwmCmKjmXQ7KD2Isd4KRDyu4yuZaKtNjUK3
	 7KEZMr6BWXGwHAzrXN2A6bU6ZI1PuyzaEZys3h93vAHfd+gh4xyu3fKlp0nWzFFbh24Tw
	 fFH6f7Jt/DdRkqUP3m5HA1i34BZLgXQENhPZYhdPdAeByHka7rFenWRt2baTFJw8uFNV/
	 J1y2yc86NAhzQke3qyTJo22iiOVbjIOJTLa54zznSDof5LeV4SnP7eS9ODO02hS/61Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791829433;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OtqK0XKCwhu1cCgqz9NNOsGI1OKogiCNbUCHlD7IIzI=;
	b=Ap7WyWmU1Ifv8eQP9wIQsBK5P+fCzIDCkc+A+Sk+46iJ8zZR15FFI3KB+ZPxtB92GVyb
	 OidTULHGetUr2CWwyypHK7dmySKCyh/mSTxgbN95+Izd4BMbX17jmJxA1afGpQVYrdYNA
	 xYTZANlCuLzVlzZ+YbEDZqstFUn10f97iD/a6HxmIic4ZRu1RnoGR7xzjblpgAi9t3ICW
	 nxyxvO7E8G8pXflIAzutZUkw2g+RVXz/2kHqERURsBBipiYj8TUD/BQSIBeA38yQsoY0w
	 Uy3F5JfEfD5fCv9B6lMRsh5nS3KC3oFN+yUwZZqN3POt1Ql8wSQ7EDarSBfN6H4uvGA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791829433;
	bh=OtqK0XKCwhu1cCgqz9NNOsGI1OKogiCNbUCHlD7IIzI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rBPlu9yMsTUIKtIi/VjHUFpspfQoTbqt5PkzO0rPy/TIbnqBSDDLjZRNaOtg8GBPn
	 phtIKcuqNDnU3CQCA3DtQTvcZMD+xQSFC3wFXc3Pc3VWy3f2Ld2fGOaAASTACygy27
	 OiJbA48UY+Nxyyxns5o1wjtJu60Z+U9mqhNFHYStts/5Swh91eezmShZ9RrJLn/OrG
	 5jwnllH1+lhXP/nSR1jr9wkszqh6SN10cyO4XV/0cTM00u4LynhhisJ+rzyiTMn5J0
	 zSPAz9+/0p5du/PUZvEGcgE6hMoiyRtIV1bYOycEcahZ2l5/nRNMGn0V9kqXgFa+Zn
	 b+HVrz4bCU4Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8901E605CF;
	Mon, 12 Oct 2026 18:23:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1C012A8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9330F8098A
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V7SflXTLNyuu for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 18:23:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 72FC98097B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791829431;
 b=nvUIsu7gLyb8rASqil6dvbnZCRbr22N7m7wbQ1/vpLaGBnSCTVIyUqx88oSUGsO+x6Lk
 AylN2hssNOqY0B4tvZzGnnxdeoLwdfbp9xgrL6JbxZNlZgOcwxdhtZrb20GHA8Tp9RiAq
 Ep8HjgMslX/ytLD4Y5h5yy3wyqlU80QMel0EtPuURECRLZeM0GqpJAbqAY0ZaOhOTwrUl
 ZnIDi+jVRYCA++05HTKYycen6Wx2hsMtzhX79pV0KnLSjDvEY2TPV9dP576ks3/AQ7HF/
 hwU5bQa4g7Z7FLTEkvRx58+yjuHxSmjDOQs2RI4nMXF6lBk7RrfY/oSlo5+MIZUXeqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791829431;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=OtqK0XKCwhu1cCgqz9NNOsGI1OKogiCNbUCHlD7IIzI=;
 b=Dq4x2zn/EikYHe4LkTelRGKtWLSqrjiqfeM1C0Z6ZiN32MFkYus6LmZI5RAdzCft/8bT
 CL9k/YB1rHbNwg2X5ZryBMQZLHLnVfifPK+zfM+aiFyouG9Tvl+kd5Apfc+XpabYZQmVE
 wBOlRtlLl9TbfVu1HNMVQuOdYUOFhmOccqVZyUqCJcUoNJRMm68pX4NEut4UtMkDy5wiH
 GX25WGKPNGjAlsyJxx01Eog+Pvg+fpdJlQPYkNkWIT0wuR1PQCanrPjBTWMk9X/Zq360K
 IHNg2A81Y1zqLH6MnY7yTLy10HqfE1i/KlZDlXqm8PjA/pLyyjXTMHgMONButqPwTew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Ym61mLzy; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cXSWv+pT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Ym61mLzy; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cXSWv+pT
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72FC98097B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:23:51 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHv4Rv1591702
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OtqK0XKCwhu1cCgqz9NNOsGI1OKogiCNbUCHlD7IIzI=; b=Ym61mLzy58Y0KXEU
 rwNWJjRKTEhrJ39UKENbfCCXtGlQqXb+hUvjAuougMxnI+N//UMBCnACXTkxQvBu
 Y2F16Fi9kYMp1jdSWQlMKjxCxNdzyws+oQw37YfhzZPkHOAgvm2fXqVNbd9GNfjs
 Sg3qhbnG1wr8hH5gpZ99kPGs+rqasyYB3fbdIPEgtlmn4MDAf+VrMEb/UXsc0N1G
 kHM/7ndsX6rpI0d9ZSrjak2SOh2kANvN+AQGfFSGcYYK7wkK0Lwh7a3mccZ+8c3i
 3hlSb1uTtjXw0Oyni/ofLa/+FnSSMoWPIdQlvhAjj20SEKnu2cmvTnLxljmcLv6r
 dRptog==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wfct6qf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 18:23:50 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67694007c9cso2856339d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 11:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791829429; cv=none;
 d=google.com; s=arc-20260327;
 b=o2X/5JPdbzeLSBaVy0zRK2gyWslm+0Prgbj61C2HKdiR/RHhkqZo3wu8MlC10aMgIM
 RyL5TVCqPSnzdA3BmhhxlpUMWN+pfB3JwYAPClu5lMUXM1+0DnftifJ8LbQTmH59J8n/
 HsHrVAi4Xh/eOcltGZzLpfsoZAsJ7uOdbm/U9MZA2Ir5SJDzRBWH39xJ6XRI27BOTFsN
 pSj/tpFVePpGJtDUw98axeW9ay7N8gjKQSaxvSFv2AXKR7n0vwKjsBeN89afTr3ZhOZe
 NSFOAsS20lgLyQPtK2lF7RbAHKIqv3i3gv8raKKC+JWZtrLdc0SI7kaGZiOUyoGZzwy2
 l8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OtqK0XKCwhu1cCgqz9NNOsGI1OKogiCNbUCHlD7IIzI=;
 fh=k2jLDpIOFtEHlAvH8l2uS9mV8HdtyhzPw7FadsLDekk=;
 b=IwkFvWLKRUcb4xXYXuujFsrDxdROqS8wDRiPFrS1viKyFYwahUpL9NK5Pe0UTw6ffm
 ozm/gduLjL2AWTXUYh/xAP1cWr3+jiiNGw1J1vZIcNvQlSp1vfMuWA8DrGRbKU6XbDaS
 VKsiLh+KZTq4+D/qbFOVXrt4eg5+iHwmp2mLvx7QCeQp+ESKvZnrZYaHSBeGzquU+hKH
 KuKTFqfEIEMJe2eAhx5CAox/Ol8XQu2Gk7plQpQ758kSVYMh/wpTFMwtNy+ElGRItqT7
 WeNS27/w+Yjdyk+aI5mBP3QgYKfszrdgjifQnA3s/9Jl5CvjaVZxDYcNlk3h7231UeVc
 Z1Nw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791829429; x=1792434229;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OtqK0XKCwhu1cCgqz9NNOsGI1OKogiCNbUCHlD7IIzI=;
 b=cXSWv+pTiLf5HfQyQwn1yJK0th2NQF7zQZpTtDTQUFsIB/ZuhWpDO4AXxldyOQkW4L
 68v7y2zvfnv9lHYpdlIIOsGNCXfGlyLsjw2jVeWaxlH46U+e3DHfBy01SzGR8oCGN9+T
 YyLrYYJ3ml3KLmIUPElJ+N7nyZgTwF0ijUzhK/5WK0e18+4uEE8FEzZOz7mUty0ZwmEQ
 +N78mjqUAqLVM6srN1wEq9oG0vjBnezDBVh5LQg+pVtXi5NVKbGkPRjG4nCVS1tioP6y
 aTkJqxawSprMF5IgjsFlva/7+z5lpr1PFZkeIm+Peo3P/lS992eLCPJHhKhzx1m8SA+K
 +3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791829429; x=1792434229;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtqK0XKCwhu1cCgqz9NNOsGI1OKogiCNbUCHlD7IIzI=;
 b=Ud4vxwGoAlX6kavew6K3bi7cLHGlk4RJjyeDysqw60rSprOAoTLGQBTQJNB03YJa4m
 9B8oEhTxIbI+bZdznfm7jlhkF7y0lcxRbVnTJpOtPPSui7i2k9hrIVwy49tOfa6iiuw+
 x1YLQaYJH9lJEj27Es8tqIAn421s+4lnubwK18MpIqXxfPWaji8VxcLA0MTnzviDRPTj
 F+J2L1gav2oJa5luZi3n9aM6mT4pZfVJdMHxb2Mo5TWXdVTuwCtXd6OWSNOvY3SWMlZS
 dlgM3rIc4z14/b4HKCoglhqy6FtjJ8owroUo9wa7Rfwgd7DTXEe9w3pkKBbzufbXl/EW
 W9rw==
X-Forwarded-Encrypted: i=1;
 AKwUvByoYD2tDe5/GGBHnqEd0nABilNOEJTpGldwvWZP/INOepKJKWGPsoFZLG32vIiQeq3cMfyN7Ak=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ3MeF1YAVZXG9E3e9PH+87s3bkRe7pm5E/7ysCKGrl7JhqOsgy
 15bzPoCkuJL3/7pgIrmauRB4u9I69iPEjJF2wI6Gj0FMPY7Hqk6Jqaijg3992a4VYjLg7eljKXl
 j3VV8HsvbTPjKnrcRs0CPobBSD8FLA83Oogs87Nh6d//2PuCXWGKorshk4cuoNO2qwbDbelPxj9
 /Ru6VGwk0UiaH5l3vWKeiagijpp7BI8Ur68dYulrouXUKD2yI1aZyqIHiE7+9G+Q==
X-Gm-Gg: AYBFou1suk5txxowr24hmTpHkTfeDrTxaZSLySU+3it/FoBok+YfOIHlDNJZiYNEJET
 BLRazKUb+Mdi2mx+y0rM/SrcqT3x+DrbIhxtmmHVnq4eVWsg3rDFHZ3N3LrDZFouCW6wj10Aw97
 X2IU0effEhXrtzitOq2iNh8/UHnEnPfJmeVw1km0FEWQ9L6AyA0gYpUfVpbg==
X-Received: by 2002:a05:690e:1288:b0:671:548e:f14c with SMTP id
 956f58d0204a3-6793698ab89mr3713835d50.26.1791829429178; 
 Mon, 12 Oct 2026 11:23:49 -0700 (PDT)
X-Received: by 2002:a05:690e:1288:b0:671:548e:f14c with SMTP id
 956f58d0204a3-6793698ab89mr3713816d50.26.1791829428478; Mon, 12 Oct 2026
 11:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-upstream-avb_lock_unlock_b4-v1-0-a45aeca54016@oss.qualcomm.com>
 <20261011-upstream-avb_lock_unlock_b4-v1-4-a45aeca54016@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-avb_lock_unlock_b4-v1-4-a45aeca54016@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 20:23:37 +0200
X-Gm-Features: AclHuK9ppw8E7nVpo0552-RzQiuwRWdmovcFWcmFXBZrpRn_nSCfRUNr5gs2tJg
Message-ID: <CAPzfCAYiLy0n36mp9Fui3ycrvXxJKtuhLPAKgxrh=KhYniPq4A@mail.gmail.com>
Subject: Re: [PATCH 4/5] fastboot: add flashing lock/unlock/get_unlock_ability
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: SIT4fbznhNmJvf638SWhAWz_aCG35W9J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MyBTYWx0ZWRfX3ARwSnW12Jti
 pMWbPADo9b51duK6ysvRR//wGH3DgIq0YfKI1sjZuKq+PxAjggldMl8TyqqXWqHzTg+Dba4jOdI
 mfJSJGHtOx2FnmXWxKXIHunwzlWLptM=
X-Proofpoint-ORIG-GUID: SIT4fbznhNmJvf638SWhAWz_aCG35W9J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MyBTYWx0ZWRfX4QiH/j2+anVc
 VPgI3q6ocy5k+OLJjUyWKqyJolmDWMUzgpYILLXNJwsb9zYgiJrfyaGWxSbdoOLuPDubb9vuur1
 IyCztlqKfOw1HYXlC7rJvTfZxeiczTv5a4kf6SSg3NajZBKPbos0tuk0LS5E6A37SYDXtTYnmZT
 f912VkJs4OeyTLYigozK4S97LqVv3cIzVoZM3ht1pK0TUWL+gOT4fHk7TaUrKf5h2umxC4wldgi
 ABjHnNrQ0KMzeXcrSOVlJCq9wIx8Ue82xasHJ/yC6ae98fqnXtXFp3cIuWUYy4SB0IUhMU1yz2A
 euk6m5p2UgQPXTMdKkj8WwoEk1v3rcJYLOe5HWOo/LltHIUAxZSwBbJGxhIJ3PFFQDbO+Dy9/Iu
 qahVHKQvlOq3wYrrNLpAXxTkrt18FHgD8rnAiqDl4EEQ1Vcxafrby7mPh0gbFrQyHNU8/cnW64H
 /VkAssPAqAfDwhlWpGg==
X-Authority-Analysis: v=2.4 cv=PbhqFShd c=1 sm=1 tr=0 ts=6acd25b6 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=d7GqylwwKBzQ2kR_3p0A:9
 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120073
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

On Sun, Oct 11, 2026 at 4:42=E2=80=AFPM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> Android's fastboot client changes the device lock state with
> "fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
> first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used b=
y
> the "avb lock/unlock" shell commands) but no fastboot front end for it, s=
o
> a device could only be unlocked from the serial console.
>
> Add the three commands and the "unlocked" variable behind
> CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
> userdata (and metadata, which holds the file based encryption keys) befor=
e
> the state changes and are refused when userdata cannot be erased; the TA
> resets the rollback indexes on a state change. get_unlock_ability always
> reports 1 since U-Boot does not evaluate the "OEM unlocking" setting
> Android keeps in the frp partition.
>
> Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
> erase the partitions and flip the state reported by getvar unlocked and
> "avb is_unlocked".
>

This exact patch ("avb: device lock state, root key provisioning and
in-place verification")
fails to compile in every configuration that has fastboot but not
FASTBOOT_CMD_FLASHING.
The extended CI job run just caught that. I=E2=80=99ll address it in v2.

> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  drivers/fastboot/Kconfig      |  11 ++++
>  drivers/fastboot/fb_command.c | 115 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/fastboot/fb_getvar.c  |  34 +++++++++++++
>  include/fastboot.h            |   3 ++
>  4 files changed, 163 insertions(+)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 1887f78bcec..b5ca8c8dcb5 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -248,6 +248,17 @@ config FASTBOOT_MBR_NAME
>           specified on the "fastboot flash" command line matches the valu=
e
>           defined here. The default target name for updating MBR is "mbr"=
.
>
> +config FASTBOOT_CMD_FLASHING
> +       bool "Enable the 'flashing lock/unlock/get_unlock_ability' comman=
ds"
> +       depends on FASTBOOT_FLASH_MMC && AVB_VERIFY && OPTEE_TA_AVB
> +       help
> +         Add the Android "flashing lock", "flashing unlock" and "flashin=
g
> +         get_unlock_ability" commands and the "unlocked" variable. The d=
evice
> +         lock state is the one AVB enforces, kept by the OP-TEE AVB TA. =
As
> +         required by AVB, the userdata (and metadata) partition is erase=
d
> +         before the state changes in either direction, and the TA resets=
 the
> +         rollback indexes on a state change.
> +
>  config FASTBOOT_CMD_OEM_FORMAT
>         bool "Enable the 'oem format' command"
>         depends on FASTBOOT_FLASH_MMC && CMD_GPT
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.=
c
> index 18d86988f4c..2e5ce981aff 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -16,6 +16,9 @@
>  #include <stdlib.h>
>  #include <vsprintf.h>
>  #include <linux/printk.h>
> +#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
> +#include <avb_verify.h>
> +#endif
>
>  /**
>   * image_size - final fastboot image size
> @@ -47,6 +50,9 @@ static void oem_console(char *, char *);
>  static void oem_board(char *, char *);
>  static void run_ucmd(char *, char *);
>  static void run_acmd(char *, char *);
> +static void flashing_lock(char *, char *);
> +static void flashing_unlock(char *, char *);
> +static void flashing_get_unlock_ability(char *, char *);
>
>  static const struct {
>         const char *command;
> @@ -128,6 +134,18 @@ static const struct {
>                 .command =3D "ACmd",
>                 .dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (ru=
n_acmd), (NULL))
>         },
> +       [FASTBOOT_COMMAND_FLASHING_LOCK] =3D {
> +               .command =3D "flashing lock",
> +               .dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (f=
lashing_lock), (NULL))
> +       },
> +       [FASTBOOT_COMMAND_FLASHING_UNLOCK] =3D {
> +               .command =3D "flashing unlock",
> +               .dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (f=
lashing_unlock), (NULL))
> +       },
> +       [FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY] =3D {
> +               .command =3D "flashing get_unlock_ability",
> +               .dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (f=
lashing_get_unlock_ability), (NULL))
> +       },
>  };
>
>  /**
> @@ -589,3 +607,100 @@ static void __maybe_unused oem_board(char *cmd_para=
meter, char *response)
>  {
>         fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, imag=
e_size, response);
>  }
> +
> +#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
> +/**
> + * flashing_set_lock() - set the AVB device lock state through the AVB T=
A
> + *
> + * @locked: new state
> + * @response: fastboot response buffer, filled on failure
> + * Return: 0 on success, -1 otherwise
> + */
> +static int flashing_set_lock(bool locked, char *response)
> +{
> +       AvbOps *ops;
> +       AvbIOResult rc;
> +
> +       ops =3D avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +       if (!ops) {
> +               fastboot_fail("cannot allocate AVB ops", response);
> +               return -1;
> +       }
> +
> +       rc =3D avb_write_lock_state(ops, locked);
> +       avb_ops_free(ops);
> +       if (rc !=3D AVB_IO_RESULT_OK) {
> +               fastboot_fail("cannot change the device lock state", resp=
onse);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * flashing_wipe_userdata() - erase userdata and metadata
> + *
> + * AVB requires user data to be wiped on every change of the device stat=
e,
> + * in either direction, so userdata (and metadata, which holds the file
> + * based encryption keys) are erased before the state changes.
> + *
> + * @response: fastboot response buffer, filled on failure
> + * Return: 0 on success, -1 when userdata could not be erased
> + */
> +static int flashing_wipe_userdata(char *response)
> +{
> +       fastboot_mmc_erase("userdata", response);
> +       if (!strncmp(response, "FAIL", 4))
> +               return -1;
> +
> +       /* metadata is optional on older layouts */
> +       fastboot_mmc_erase("metadata", response);
> +
> +       return 0;
> +}
> +
> +/**
> + * flashing_lock() - lock the device
> + *
> + * Verification errors stop the boot afterwards. The AVB TA resets the
> + * rollback indexes on a state change.
> + */
> +static void flashing_lock(char *cmd_parameter, char *response)
> +{
> +       if (flashing_wipe_userdata(response))
> +               return;
> +
> +       if (flashing_set_lock(true, response))
> +               return;
> +
> +       fastboot_okay(NULL, response);
> +}
> +
> +/**
> + * flashing_unlock() - unlock the device
> + *
> + * The unlock is refused if userdata cannot be erased.
> + */
> +static void flashing_unlock(char *cmd_parameter, char *response)
> +{
> +       if (flashing_wipe_userdata(response))
> +               return;
> +
> +       if (flashing_set_lock(false, response))
> +               return;
> +
> +       fastboot_okay(NULL, response);
> +}
> +
> +/**
> + * flashing_get_unlock_ability() - report whether unlocking is allowed
> + *
> + * Android gates this on the "OEM unlocking" developer setting, stored b=
y
> + * the OS in the frp partition; there is no policy for it in U-Boot, so
> + * unlocking is always possible.
> + */
> +static void flashing_get_unlock_ability(char *cmd_parameter, char *respo=
nse)
> +{
> +       fastboot_okay("1", response);
> +}
> +#endif /* FASTBOOT_CMD_FLASHING */
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index e8aa0e09aa6..92c8e702a0b 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -28,6 +28,7 @@ static void getvar_has_slot(char *var_parameter, char *=
response);
>  static void getvar_partition_type(char *part_name, char *response);
>  static void getvar_partition_size(char *part_name, char *response);
>  static void getvar_is_userspace(char *var_parameter, char *response);
> +static void getvar_unlocked(char *var_parameter, char *response);
>
>  static const struct {
>         const char *variable;
> @@ -88,6 +89,10 @@ static const struct {
>                 .dispatch =3D getvar_partition_size,
>                 .list =3D false
>  #endif
> +       }, {
> +               .variable =3D "unlocked",
> +               .dispatch =3D CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (g=
etvar_unlocked), (NULL)),
> +               .list =3D CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
>         }, {
>                 .variable =3D "is-userspace",
>                 .dispatch =3D getvar_is_userspace,
> @@ -346,3 +351,32 @@ void fastboot_getvar(char *cmd_parameter, char *resp=
onse)
>                 fastboot_fail("Variable not implemented", response);
>         }
>  }
> +
> +#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
> +#include <avb_verify.h>
> +
> +/* "yes" when the device is unlocked according to the AVB TA, else "no" =
*/
> +static void getvar_unlocked(char *var_parameter, char *response)
> +{
> +       AvbOps *ops;
> +       bool unlocked =3D false;
> +       AvbIOResult rc;
> +
> +       ops =3D avb_ops_alloc(CONFIG_FASTBOOT_FLASH_MMC_DEV);
> +       if (!ops) {
> +               fastboot_fail("cannot allocate AVB ops", response);
> +               return;
> +       }
> +       rc =3D ops->read_is_device_unlocked(ops, &unlocked);
> +       avb_ops_free(ops);
> +       if (rc !=3D AVB_IO_RESULT_OK) {
> +               fastboot_fail("cannot read the device lock state", respon=
se);
> +               return;
> +       }
> +       fastboot_okay(unlocked ? "yes" : "no", response);
> +}
> +#else
> +static void __maybe_unused getvar_unlocked(char *var_parameter, char *re=
sponse)
> +{
> +}
> +#endif
> diff --git a/include/fastboot.h b/include/fastboot.h
> index b106d617749..e8b6e293173 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -53,6 +53,9 @@ enum {
>         FASTBOOT_COMMAND_OEM_BOARD,
>         FASTBOOT_COMMAND_ACMD,
>         FASTBOOT_COMMAND_UCMD,
> +       FASTBOOT_COMMAND_FLASHING_LOCK,
> +       FASTBOOT_COMMAND_FLASHING_UNLOCK,
> +       FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY,
>         FASTBOOT_COMMAND_COUNT
>  };
>
>
> --
> 2.53.0
>
