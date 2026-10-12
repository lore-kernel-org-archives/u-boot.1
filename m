Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFFCA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 08:11:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7930360618;
	Mon, 12 Oct 2026 08:11:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bu26H55qgV1W; Mon, 12 Oct 2026 08:11:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8690860619
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791792666;
	b=EXkbOwF93zD2ro9POe+9upMXDPeDuaYQgkpecbMw8zbeIcQ1sa85AhdSiMcg7j2vZXk+
	 n+Uojd52R2OLOn4DcD1ys8t0/e6mhN6w7k+ka5n1LvADdLCqVk60LO6ZOIdv5lLNC/VxE
	 EDT1HMQoIOzaLHLyGugHHKrb3DuRexnbDBb/e96UvWZT4R3f+DNwhS7+FJJ4oreTckmjf
	 rAPZdgh5BJGYYAt+sDHJFdbh4O+/qTauAKFuec7pKpT/hcOviw1tL+G4kXs1cz3Z70GXa
	 tgi1Lao8jMVrf73I2efiJU8411sw3oVNaDZVtIaOz65gNAXmglcAsJZCHclKpyJlNBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791792666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dqjot2ufiliWRB3xmo0VqQxkzHah1pYjyltvftZY9u4=;
	b=nNkFgd60ukr9xMw+Fx9ntHQfNnn9EO/m6zEHV8nXhFIb/uSIwgc0B1DH/Ji1O++m+ojv
	 xld2sSl9+Qfn795hAXQ5wYKSjk9VuM6CJ52jVZWd/ssrlj8YpKfWTjx+LzbX2boWoFJdP
	 913OTL8GPpLgXBhmbIB391kJMxkVDCtFoQmXZ4NFqYAjGsthRiI8K9ZssBAd1avoWNR1e
	 /luaNBTp3emf+LUQAupUeKWrAodqbGDzLcH6w4KiHtw33BAO4ewuo0vooAugtsC1yRzGn
	 Cb/kxrVM62K/NEfsPARHyt1aauM/Knywern+HnH1c9i/BSD3u/EbDa/W0U2GuNTA+Fw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pGHEBMMX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ehmwhv7p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791792666;
	bh=dqjot2ufiliWRB3xmo0VqQxkzHah1pYjyltvftZY9u4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLijE/ASStoJyUNCN5x2bXf3QYTE8hzPENEcl3jelvcXnSTIxeBpRLkKbmbPR27FZ
	 c5W3Y3OaaztJ9m6J1OapxqmciCVbMiEZtJlf8MppYjLAsJ1SURPlfZpQgr9+YYj4jB
	 VX1NHLVfrH6HQwmZcoz3kjiG55LiuzAaFjOyLcJKzgrRRPn7iAy5QImvlWTGK9khnG
	 DGb2ZNmhjN1tsA39uKfsYQafzxXs6XsC5T9Lj9zrSD7L/BW0cfjXlEC4mkFmvFMeeM
	 fmDXjp3XrgdYRxuw6QnJkDXD+whu2M3fmLxTTNcvmS/oN0M7fy5bZnzOSHo1OADMjT
	 aZMKjsOMm2+EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8690860619;
	Mon, 12 Oct 2026 08:11:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C9B39DF
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6308C6061D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPHSeSlIBYpA for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 08:11:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6480D60618
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791792664;
 b=EJ7JHS18MqwbwPQtX6NcbCUKDPeAsu8cv7BuAXRA5xcZw4jaAU61QhLKEqlV561dFsga
 dQw0HFvHwUI9lDEuKUZe+LzCxBqpZnb4b3TCo6E2oq8rvaFbQmdsI2cwJJDdjPyrpIx7T
 r8Y1lnEcPSxXOyham4sUZGjbz7xBZSTCiY0F65FX90mW9vAZDt7lic6ZBWA7Xgl61GkPS
 bFddkGifbp735+VpGshzeVhlAo8jhpIAJQHntkK+Hp/XsJaswTmQewG1TXtgt1E+wUaig
 bbBhaGEYIbbYVq76KD1FYd0tWt5ynXrAgKIxq/2jvr5b1++qdA8lxfVHC801/WQDUig==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791792664;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=dqjot2ufiliWRB3xmo0VqQxkzHah1pYjyltvftZY9u4=;
 b=qE0Z+q6I1Ya0QYE9U8R3lw87+ssMnEjk6TEpGMghMcx6CEGjuPmu1kwAF/cG8a39voI+
 Pst9G50mT8ymQJQTHGoJXhNcxSI5sn/h/ExHf3Mz9F4rwV9xN3XcidaOCJlhpOM3yqTzh
 RBIuiEiktf3pf0ggH7WBZ3MJtcCZN1vRFkVVsbEE8aG3PD6EfD4WWPelyyi0bmGXMYiap
 Sg7MDjFwgeiUzeTugCorzIqnV/N/mQsBboYZBb0ADMsJ27t1djEJE4kz/ab8uMxW/hZtx
 OsU39ZD20CvbmDsp1JTvWbwdxdqSlhA6LqFWz2/FDNteJd3I5h4l2/vnkFJkBHdSu4Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pGHEBMMX; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ehmwhv7p; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pGHEBMMX; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ehmwhv7p
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6480D60618
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:11:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C7hQ5M1694980
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dqjot2ufiliWRB3xmo0VqQxkzHah1pYjyltvftZY9u4=; b=pGHEBMMXIfqLoToB
 ox17oNOE6MAcAA76TmdD6zjG40ZLdZpptGnM1k4bu5lkJXSGiK5yr/U0dLMP1Yk+
 Pr/LWaRMbJTJA27xNOb53I0YxcQ1H/Syv6c2g+MFVbCEkBd7MqP2hpkel8TZlIaK
 DSHg/18fxTvyvRS3Qzhc0zcfqrDiNuwB67eryBHBJpIkjBKCLCD82Uyki24OjI4Y
 dajfHPRn5OYkuAt1H/g2E1KTQE8fZLtZPfiCB9gDG8SuUeIqJkCWwRPBCNaKCf16
 P6b7lWTP3OesCTiFKbVSJVjCZhohisfU7L3W4NNvKWa3SrivVkZhcRv1+3XE/CAn
 Cpc8Yw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8udq03dg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 08:11:03 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b0a4f77582so5607937b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791792662; cv=none;
 d=google.com; s=arc-20260327;
 b=QGosikc9Sg2Dg6Qgul27eBWKx+tQRRNoBWXmTa1Z/psZRuBVOYhMwhAh/iBPSVfcY/
 sfl/1iIzAens8aCCM7dXuS8Rf8Zte2bXTgexFuzo4AD1/5NqGeIl44E+bpMVv3vezBS8
 OshRr2NHd8J/iaSG9aHCgDpBqLUVHQI2qE3CaFUj62Q4ShALNGgYgipJVilesPWzcpvD
 el74sIlIEN0teiHw4vP4nx//KFvwb0iBMYjxUmwqWjbWMk1oYKaO6Wck8GbMQ9A8i4Cj
 VLhtEbFGBXJNo60gnkc/8CpiTfFUjk/Og2qfHHOkQlqcbly2sgXrX7HNQUk1U51TAkY3
 DtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dqjot2ufiliWRB3xmo0VqQxkzHah1pYjyltvftZY9u4=;
 fh=WtgqmZa7PjYirGKKEC6L8aHi4sQhW8wf3eG5+KYd5EA=;
 b=inF1x8i/gLTiAwXu84fEhR4YzDC/Z+mbGULh0KzO/Tqj7UxXP6hHkoSmRJ29PrYWZT
 nf5pKrNqEYJkayp4MSZ146a7zR100OuAox8Qo8CkqklE9vhW3HVyl825wk80IiRQX0Nz
 aFGMQrQ1Y2ZMF92+gVcekK/CGkwgoGErTM5ZSlwRbtw8bCgC4DP/mHho+pPZ/Cb8BPqt
 QaoKBbxIeJNR1eoFX5NtjM8HtjAJ0WP37Z64ehBHS49eB+vZPjlDla7kdcHARIqXkxhD
 XPg+N0WsfyhVzfdFDI0RJrvywy4UpFytLnHH++/3XncjKRvcVp5tGIn7iD7nXXFIH0tm
 VOMQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791792662; x=1792397462;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dqjot2ufiliWRB3xmo0VqQxkzHah1pYjyltvftZY9u4=;
 b=Ehmwhv7pbhHOyJTp7PCX++fGS8/74Ohp7qtyl0NMiyZNv93bZpk+tITrvu+Mr2Jxto
 ZUiGmEIzfMB4dnVl4xX8XTaDuo4CzEmXP5aV1c60KdBXWoO/7lqKSXFF0UNI7hmFPVZE
 K+rUogMTiqaMWD2ZcyeGLXbSUuXr07v+17xIuGPxyaCY4Yxaytx2Hd5+PsCSn7h5AUIE
 OJxum+/MvMfd9B6JBTjzhW5AYn+JeAHVLm7H6V696ShFoe+Wl3yIGtJ1JJy81MwKcnsM
 tvS6zUASHgFlbGu8UEcryhMk9V5I/y3rq+TNZ6RwpVdSQ0V0w2cFm/6oEhLRBXmm54qV
 NuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791792662; x=1792397462;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dqjot2ufiliWRB3xmo0VqQxkzHah1pYjyltvftZY9u4=;
 b=iN4QPRzMBiKb7e4THGaRHjdDV7RCPCSQ2KPgvyi+ry6gHTFSzIFqo17UIkLreQ2us5
 LvkFsUDIn3NSi0cFtLyCS4BDRiuXH7c6AjuF8FTtym/q3EWnSqPIlvF+8rf9WMxIuiNN
 g1GbUm9WakYCvQrjI42uj/gJIhWpDZfErkboVpxQI1/Q8n37i7NCwA4U3KMjRjgMI7cU
 /SmWWCLvtlcweS7dtc1X8+oe62bxYRlXVtr18meqGOZ8nMsS/7CgWTWRKMDLdy13nvmZ
 UNNndCDn3WCliQmkwPoYRPyMHBp6EavuBvGGvBzY8jQSgYZC6s5GHBXB0rkL786TXwq+
 /JIA==
X-Gm-Message-State: AFq9FYJ0H9yyzHZGAd1jwMMYhdLvG3UPNvXUlXZrrvewHBdFjToFao//
 ROEYc1FQ+aVYltRqTv5ItkWhzr7piXh+SpE0uj1WTF3E59BuX3/nfhe8XOuOElMHDd01MAfYkp1
 EpD76sW74mwTJdr/sHTA5Nc8V/oq498QyN7p9XjO9pSEQlcWkDDRQvoJESCPL8vM9bNc4fbyUK/
 fJ4jIRot5vpTYInZRouTMhTJnwpYPurbOFprA60JI/hzfpYg==
X-Gm-Gg: AYBFou2Q/w59vl9jzX00q7D9ynfmUvrS+3e+M/y7fLpesr1cMBEnNpYM29ok44nlY5R
 hGHRE56CVLBsMNpHmJTvdHQs9cUPAn44E/8F1jPOMnOx05aTYc+ya3GygTZf4CQ89qj34rq6ALs
 h1c/kiB8ST9WxScsICIMUeox076hNogBMd+gmdfn1Td7EHN90JHgYGJTnZ6g==
X-Received: by 2002:a05:690e:11c3:b0:677:d155:1332 with SMTP id
 956f58d0204a3-6793629a13emr2401127d50.56.1791792662035; 
 Mon, 12 Oct 2026 01:11:02 -0700 (PDT)
X-Received: by 2002:a05:690e:11c3:b0:677:d155:1332 with SMTP id
 956f58d0204a3-6793629a13emr2401120d50.56.1791792661572; Mon, 12 Oct 2026
 01:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
 <20261011-upstream-optee_rpmb_b4-v1-2-7c63edca4b92@oss.qualcomm.com>
 <77d8fc9b-ab0c-429d-a1e3-05e558188f45@siemens.com>
In-Reply-To: <77d8fc9b-ab0c-429d-a1e3-05e558188f45@siemens.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 10:10:50 +0200
X-Gm-Features: AclHuK8xmhVkB2zjKThACaVaB2QgJhv510ZrHvx-l26dcqFmPt1bpU2kQL3qA1o
Message-ID: <CAPzfCAbc6JQBz+VR0O72Zd7csNBSC-QSHtbnrHLL=E4g=ZKEAg@mail.gmail.com>
Subject: Re: [PATCH 2/2] optee: do not announce RPMB from within a supplicant
 RPC
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=evJKXYpX c=1 sm=1 tr=0 ts=6acc9617 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=a_U1oVfrAAAA:8 a=EUspDBNiAAAA:8
 a=RLHEAi1GgnoOQ8FhNAgA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX4aLzAIukYcen
 1UhrFHtVsBU/66NBgXxMCgEbDmhk699tex2+8uvpfQ8Jaz9in9VLB9Wf/7dtpPGo2pXJj4jr4UI
 CvrPcKtjYVfuELjgop13kWLdo0a0hDo=
X-Proofpoint-GUID: 294kNXZ4AIqm5u-WQIqq6J72V8lKA6g3
X-Proofpoint-ORIG-GUID: 294kNXZ4AIqm5u-WQIqq6J72V8lKA6g3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX+/irpRDDhaEF
 5k4twlzOaqjhwhaRs5q5cogMNyom85y6sw992hXHA0IQD9ZLbzc3nWm+5Q6mSFBVbLR248Uij5D
 fgBXKlC5iCSidSdJuYderCbVmkUp1l/VCQ4zUv1r4y3uJRZ4QX8A3ScAZOJvnPBVtQjGtTRbgX2
 oJMjIa08y6Xn2od0yAX1H23Y1I3coqHP/p2kA8mhnOOw0FQkOw56/BQPTJqI5k1z7xh58cH7Lpm
 /XYVn9tS2aMRvHFFYz5mPWGpLIQtYh9QuxoNTshy9ctVoFWuAmGo5HA1lQ6MdFW7aes8iIfVJqR
 XSQ8QjpdJ9B6FrShUAoSjz8vn0LJ/I1W1dZVT+i3JnzZr9juwUOfL6+6UTAPS9ELCrUBmNWIRVd
 xAxWdlFO4hbP9nNr78j6y9MzprV9hzOoRY+3ksnC0EoACYQ1cpMR99RCOhyoUB4XY4E7o3OJTN2
 e2dnGgD0O9Xgq545ZTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032
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

Hi Jan,

On Mon, Oct 12, 2026 at 7:42=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> On 11.10.26 15:07, Igor Opaniuk wrote:
> > mmc_init() calls optee_rpmb_available() once the card has been set up.
> > When the first initialisation of the eMMC is triggered by the RPMB
> > supplicant, that is while OP-TEE is blocked in an RPC and holds its RPM=
B
> > mutex, the announcement opens a nested session and OP-TEE's second thre=
ad
> > spins forever waiting for the mutex (U-Boot has no notification support
> > to put it to sleep). This happens whenever a TA touches its RPMB secure
> > storage before anything else in U-Boot has initialised the eMMC, for
> > example a TA call issued from the shell right after reset.
> >
>
> How do I trigger this exactly? I tried via StMM (env print -e), but that
> didn't cause issues in my setup.

The first mmc_init() of the eMMC has to happen from inside the RPMB RPC,
i.e. nothing in U-Boot may have initialised the card before a TA touches
its RPMB storage. On QEMU virt (eMMC on sdhci-pci with an RPMB partition,
OP-TEE 4.11.0-rc1, environment in pflash, no "mmc" command, no bootstd or
EFI block device enumeration before) it is just:

  =3D> optee_rpmb read_pvalue test

right after reset, with CONFIG_CMD_OPTEE_RPMB (any TA that uses RPMB does
it, this one talks to the AVB TA). With patch 1 alone U-Boot never comes
back; with this patch it does. The OP-TEE log (with CFG_TEE_CORE_LOG_LEVEL=
=3D3)
shows the sequence:

  D/TC:? 0 tee_ta_init_pseudo_ta_session:303 Lookup pseudo TA 023f8f1a-...
  D/TC:? 0 legacy_rpmb_init:1219 Trying legacy RPMB init
  D/TC:? 1 tee_ta_init_session_with_context:578 Re-open trusted
service 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
  D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
  D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
  D/TC:? 1 do_notif:34 sleep thread 1 0xe9b3d570
  D/TC:? 1 do_notif:42 sleep thread 1 res 0xffff0009
  ...

Thread 0 opens the TA, tee_rpmb_fs takes rpmb_mutex for the RPMB init and
issues the RPMB RPC. U-Boot's supplicant runs get_mmc() -> mmc_init(), and
mmc_init() calls optee_rpmb_available(), which opens a session to
device.pta (PTA_CMD_GET_DEVICES_RPMB) on OP-TEE's thread 1. device.pta
runs tee_rpmb_reinit() and blocks on rpmb_mutex, held by thread 0, which
is itself waiting for the RPC to return. Thread 1 then tries to sleep via
the notification interface, U-Boot answers TEE_ERROR_NOT_IMPLEMENTED, and
it spins (about a million iterations in the three minutes I let it run).

Your StMM test does not hit it because the eMMC is already initialised by
the time StMM uses RPMB: the EFI subsystem probes the block devices before
the variable store comes up, and an environment on MMC or any earlier
"mmc" command has the same effect. The announcement then runs from a
normal context, and the later RPC finds an initialised card.

>
> > Track whether a supplicant RPC is being serviced and skip the
> > announcement in that case: OP-TEE is using the RPMB already.
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> >  drivers/tee/optee/core.c          | 3 +++
> >  drivers/tee/optee/optee_private.h | 2 ++
> >  drivers/tee/optee/rpmb.c          | 9 +++++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index a47c76811cd..b61f907a3ff 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params,=
 uint num_params,
> >  static void handle_rpc(struct udevice *dev, struct rpc_param *param,
> >                      void *page_list)
> >  {
> > +     struct optee_private *priv =3D dev_get_priv(dev);
> >       struct tee_shm *shm;
> >
> >       switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> > @@ -450,7 +451,9 @@ static void handle_rpc(struct udevice *dev, struct =
rpc_param *param,
> >               break;
> >       case OPTEE_SMC_RPC_FUNC_CMD:
> >               shm =3D reg_pair_to_ptr(param->a1, param->a2);
> > +             priv->in_supplicant++;
> >               optee_suppl_cmd(dev, shm, page_list);
> > +             priv->in_supplicant--;
>
> Wouldn't it be enough to track this from rpmb_process_request? The
> nesting issue is limited to RPMB requests, isn't it?

The deadlock is, yes: only the RPMB request is issued with rpmb_mutex
held. I put the counter around the whole supplicant command because
announcing RPMB from inside any RPC is pointless (OP-TEE is already
running and will probe the device when it needs it), and because a nested
session from an RPC occupies a second OP-TEE thread, which fails outright
on a build with CFG_NUM_THREADS=3D1. A request that is not RPMB can also en=
d
up in mmc_init(): a LOAD_TA request served from a filesystem on the eMMC
does exactly that, which I have in a follow-up. But I have no strong
opinion; if you prefer the narrower scope I will move it into
optee_suppl_cmd_rpmb() for v2.

>
> >               break;
> >       default:
> >               break;
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index daff3e04493..92e3b3bea10 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -42,6 +42,8 @@ struct optee_private {
> >       struct mmc *rpmb_mmc;
> >       int rpmb_dev_id;
> >       int rpmb_original_part;
> > +     /* Non-zero while a supplicant RPC from OP-TEE is being serviced =
*/
> > +     int in_supplicant;
> >  };
> >
> >  struct optee_msg_arg;
> > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > index ea5507af086..cc82fcead0e 100644
> > --- a/drivers/tee/optee/rpmb.c
> > +++ b/drivers/tee/optee/rpmb.c
> > @@ -224,6 +224,15 @@ void optee_rpmb_available(void)
> >                   !device_active(dev))
> >                       continue;
> >
> > +             /*
> > +              * mmc_init() may run from the RPMB supplicant itself, wh=
ile
> > +              * OP-TEE is blocked in that RPC and holds its RPMB lock.=
 A
> > +              * nested call would then deadlock, and OP-TEE is about t=
o use
> > +              * the device anyway.
> > +              */
> > +             if (((struct optee_private *)dev_get_priv(dev))->in_suppl=
icant)
>
> Using some local optee_priv variable might be nicer to read.
Will do in v2, thanks

>
> > +                     continue;
> > +
> >               if (optee_open_enum_session(dev, &tee_sess) !=3D 0)
> >                       continue;
> >
> >
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
