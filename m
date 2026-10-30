Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B11606A31C
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mMFb/0nv;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YCXkvgtz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YBIvuj+h
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73F2140ACB;
	Fri, 30 Oct 2026 12:22:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WfevCRrNheUm; Fri, 30 Oct 2026 12:22:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BE78D40ACC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793362922;
	b=SVHCciyau5sdllrIHk18x34jt9YzhVyh2fFi3ty3vIEjDShaUgYs+wdPdIoEW/qo+bNr
	 5tOz5g7ep0GfMgIuAV/MVjhXA52xTFg3qMhJEKSEUIZuHFUrsALSkJIAuSwDqTCUdV/6z
	 D7MHUYYKI8252sfYyneN/BE2tXas2f6Hz5/2WeHxkYgDURWX2/YOEE7R08bkJEKuF36nI
	 MnKmUmmUa6we0DUiv7nNPeik2ADcYB1XV7PrE6LExMMdbkQxbhH8ww+aUZjfuy/b6CzkT
	 pBc2QIbS8SJpVuRSLpEaHKlAjTUNLYedeyBDVzu/xMSfhY5ryXwlqQNIfKhwzGy5wSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793362922;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yacCvCz/2MXg1tAU/dFDVtIkl+HVVSZvfx0MLbdK9bI=;
	b=ES3xLHRmoDuMuPrFDnlKJJFjxivTwqEUuhFcoeul4CORO+xJLAnnBGKkoF+UcVjUBIeH
	 2xltUkRoE4zu8IUKQYwsi18nnID0IVsyY2gFC7BrNzFC1bPMaX7pFdfOME7ccJy9nRqrW
	 C/ZGZu8TaHsFeUPIplIaqE8ZBB5WBy3pW+IyN/F4q6cKqE1UHEJVOFttMXrQRKbUz5Pdy
	 QZqcD7jRjWHFPMtokWcADMb+zD7suxJnZyolWHNXcBYEQXFoTv5AIQfyGP++AcDc0mzHe
	 vjKoe3lc/9veIsCr4X8h79AgoAIzIneYP5XkNx5WJupa9C/kQoZL7yzFHuwkHCqiwBA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YCXkvgtz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YBIvuj+h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793362922;
	bh=yacCvCz/2MXg1tAU/dFDVtIkl+HVVSZvfx0MLbdK9bI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mMFb/0nvbwxEgGxGUbrTymfrpbCkpp/Gg47KZG7grL/U8M/Kv/+sw/D+NHOibPmW/
	 oZSU0StrURUMCnYxsyrm2VK6h2pPi4DFe3HHDoWjtu2dfQA1hMWsFSxKaEwokXE+Sb
	 P/pJpxJp80L/ua9TpGkRYsnTHP2Dqj1E449XUMyIKKxRBSuVIASO/KhptDK6mV39kM
	 53oxrgaRq2cl2++dEsEQXN53X+wn1DnWF0CQrr42/zibvjS7pbKSFEWg6Le1dLKe1P
	 Xc4Rg26M18l4wGlXo4Iud+0Xcp3FduaGhurNWmG7gSy2dsVhXfs2F1eruQSMDyEP1Y
	 J4Km/jpNKlXSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE78D40ACC;
	Fri, 30 Oct 2026 12:22:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ED6E44BC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:22:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D348540ACC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id esXcBtV-JyfO for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:22:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2AB1B40ACB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793362920;
 b=nKA0s85uZAwUYsPBuUJhzgNdeXUyG56WkQp/jJIsJMHO3914xpMvQiGqPY0GbrUltQJp
 ez0VNr7nEX6u/z4OR3LPrTgFFb7P4alNIDhXZFDrTH9o9ZRTGuZuvFvcCvwDpvH12tC0M
 GvxXs/T8+kRkjI4f2z6KJIs2LmlNtEABIYi0KhxFdmAzezuFjRnGp2gSln1AkZQTsi4sI
 3SDchBGRJq1peGmPFhDcrvfEN/8hdRwsY1qzZtKmjplfrd500FFhAcQRUptLO677jpYnc
 HEbQejIXsH3Ndr0NDkhnq/HiP+mpHkQ6CzAKzc6aUQ1S1zny1gWrzVs6YO6usEjFCyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793362920;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=yacCvCz/2MXg1tAU/dFDVtIkl+HVVSZvfx0MLbdK9bI=;
 b=MZOE53p+ODV8TTS4BYUeIla9EZGzrN12ua0JnCH+g1ZTXiQON1V04nhTs0GewEzxYcLT
 lx0xw60L5b/YCOGEnl8S8LZpifiCWA+LVKVLShrhxwYCWqwhTHcejF4gpMzJ+0iprdp+9
 uPVoBZa6RiMZ2U/Qek/v/VHd/j9m4UJ5ZVH/v3ruElJ9V4Yd3xEryXjkOHY8hD7KrFZE2
 JE28TpSRfYQSjTR9H5DE3q11LXIUmtgoJL1xd52xKR94x1e9Ogab8UnTcqMWjoD2yc0Xj
 zE0be4rQeWY4m9AvqjhcMrFt8HN2gyySIHDoOZuxauDaf/gI4CBH0OQCSoqNM9/oMow==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YCXkvgtz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YBIvuj+h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=YCXkvgtz; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YBIvuj+h
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AB1B40ACB
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:21:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGDie4144837
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yacCvCz/2MXg1tAU/dFDVtIkl+HVVSZvfx0MLbdK9bI=; b=YCXkvgtzeiSCAJEW
 +aCihN/Oht/5AgDuEzOMKEF3orTvG1NwW9Omn9Ldrgx1eOJuuOctUzZDtgO9VyE0
 zy8Dq2i1TR+k3l5dFB/a2lFDgqtM/YGi1T8ZOZVb4IsJTXrIEogXYZA/vu6amVJn
 YNXN6h1oeqB1o+EH3CJOvR7qhNfFz2Khg2aAG/DnjB6sXxnzL6Huz3t6Iq2YpQ0V
 /BAj9cr7ioi+8JaIA9JUVUp/U+GrnZqPaPp5iN6N28CmhqoZbmdRrmWj3IkcAIQ8
 lCUckKpZBo+YvIxh4UthBKIUlNwyflNO74QvhoC7H63HgVIWN7OujVbfzMFpf7G1
 Dp3HyQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme752y3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:21:58 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6795a39e53fso2606059d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793362918; cv=none;
 d=google.com; s=arc-20260327;
 b=kXkWMc/knlczLU0ohuaS6wV00ImMGR2/O4eCkRzZq2n2iKkTmJ5/2i3GENdhvTQfum
 kNJhdaFcFNm3VoZHeayr1/8Tsv9FJwH3307aH5epHO87GAxWhy0nNBieDblKDKNQQWYz
 PI1qipyLKOFI7FCiZxMHmxf5lzbbdZwDulZIdgGlEqq6QiddDP8GSkKoBeFM14vl1Yug
 EVInNuJQBuuDHtcOXEdaE3XSy7aDHXqAI3faDq7F81B2gUHWKo6XUJ3QvWZOWwZ18/ZP
 pq+zUxTVxut70reRHJclpyMnGVRBrpVnYXM7mdegi5X6r5xwT4B/pEp2w81hUNBT4Dy0
 m+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yacCvCz/2MXg1tAU/dFDVtIkl+HVVSZvfx0MLbdK9bI=;
 fh=/ZXtV0RkCRLkvlTxSPTC5AweNo3tMElqpkaaUvEEabQ=;
 b=TkruipB4eeEdgmm3POZLJ9bZ9m8CUk5fl38M0plStJGMfveKCYgL4PTN6iW0sNj5pg
 dYPOdeG6Uexs5dpdCvhNxEtXGX1nUXDgqHuuvbkO9OuyUpFIzqXn0Xeyx0KaGDx/g3hj
 VZKDr7lojgKqhmz9o7YmMVUG7se66MOq9Z3WjJPA7wgAoLuzxkd0lMo+HmRQDegmIyb+
 HAklMOr7TjGyIbKKByIqSu14ucI0b/X8nsqTX6TiKIPyfwaquNiKLIR2mBKbSv7XaiZM
 jzWOXxRm/reLER+SVDzbHtEIBj1gQ6qpLbkL2Kp/kfXy/qbqqiVYob3fuMbufIP0RZP4
 HNdg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793362918; x=1793967718;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yacCvCz/2MXg1tAU/dFDVtIkl+HVVSZvfx0MLbdK9bI=;
 b=YBIvuj+htctGT5L1F3rhZuh3sRXbl7icX2Ofo6/yAaDDSI7oOkKsS0UdhPea765A8N
 VtI/eZzAaBdwHMCT0f7uP4+eyBlSBrGwKDQyukeUmyGegufYjxzgTnJpegoVX7SIadee
 EKL9IAvPM7TWwLZmcAEjc/YjWj3E5bZpO6qedBMi5gmeODsynZujYYnRkQ9o5Ogu15sz
 Gk3tdasj1lvzipzt7+imiYRUSLj9/Ns5T0MSJ62lKwmmq6BDTweE3FjXbdXf2uzCXNwn
 +Q+7lcrH/wgaiBG2JQ935+sTgel4SymanlliqDcUtxbrROYIRvYQhQavVu0bbHpYy8zs
 IWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793362918; x=1793967718;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yacCvCz/2MXg1tAU/dFDVtIkl+HVVSZvfx0MLbdK9bI=;
 b=I7X/n2Q+RkXzt+hFJ/BHVYlufpbZw8dV920vBtJSRFScggEoGA6VIfChvqWg3J3m5L
 iq7JWLVaxxgLeIa4tso5mL6pa0Rc/+DSzG+/cl5yZQyP+LoZWDysxOlmFwYbnR7+MWK3
 wT/Yo0EtNfzb1CPeDK/eJqoXf78grOlI0srlYIV2+3d/CowRfKDNt1BiAd98qBg4ckqL
 KtPBFSzf1j4l3qjl/jOgfH0hXP/YhAGR4XLTGAomSHYJGI9mbkh6PwogRcqFipeIIoEY
 /ng6wDHxJLQC82gAR2jyXGXA8d5RLgN3ad6oJa4g4QjSYTWiIJjo7+joRwQyUtRwbR4e
 eHjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0MaRA6WQCx5ffdUhwxROC5P5PbmOeX6d9QcylaQcc7+zKI4wMEgz+DsPomxzl2UKI1Hegvy4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIAkpgXI+4uc5j7wzpJszy+J5PmLzHnPxxE9+EWGC5+sYNf1beJ
 alpuIlefFnGxOQVHb8dniJ0IBE2pz14azp24AsPVnvOKiUZVS1+OF91jA4FXVTjtHcMcIPi+V+g
 mRULKSqTuIbe9I2rY42CmQVKjqL+zNqJ6g0oCN9PlsOm9dgtLT7Qbpn8k7Yl38REldQSMr8WSq2
 ldj091OlcJwteJ6raqgx35laqE0sSwkfusB3CA1wWsgYA7vQ==
X-Gm-Gg: AYBFou3OONufK/Zet0hy65ND0AEFdSOtiLv7s5I52TfD8pOjv4DWsC0BhPcIBgdQoMe
 /m/stVjnUqP3RVQJLtum+S2I7Py5y7diVQfpJJ+VxLim5VpnRRSwwEf28IfTsbvu82UmhUGnOA8
 Hed+IqgAdAq7X/wVXnt08C4vBYozJGZ94wfNeekomobWBFrAuZA7YR0iE=
X-Received: by 2002:a05:690e:1902:b0:677:b7c3:12c3 with SMTP id
 956f58d0204a3-67ba4fe5fa5mr1307413d50.29.1793362918012; 
 Fri, 30 Oct 2026 05:21:58 -0700 (PDT)
X-Received: by 2002:a05:690e:1902:b0:677:b7c3:12c3 with SMTP id
 956f58d0204a3-67ba4fe5fa5mr1307403d50.29.1793362917613; Fri, 30 Oct 2026
 05:21:57 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com>
 <20260902170559.3225833-4-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260902170559.3225833-4-aswin.murugan@oss.qualcomm.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 13:21:46 +0100
X-Gm-Features: AclHuK_iRvWcSKix0L2lUuqnqYS9abVVTRQ877rZVy6X5NMlDDfFljTQ7667MKY
Message-ID: <CAPzfCAZgfBA8ck4TrxTEtWFd_fTBth5cmon3jK4SuDM1txnMMw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] configs: qcom: enable CONFIG_MMC_HS400_SUPPORT
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, nathbappai@gmail.com,
 varadarajan.narayanan@oss.qualcomm.com, quentin.schulz@cherry.de,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: o1FWPs8ifk418wAElF_1gvHZCiXVeijS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfXzMpimFXMilAC
 EkJ0EWx1snbTeBDEiczWc+Cw0YduaEU2Oar58Y3o80sWQTVxwhHNEpAhQj+EgXLVtYU53Zl8dT2
 FtenBR3SPiP6V+uwX7/2Pi2g+te/Le99pGuePrxjZvCl1ElVMKuxNQmPNhwfn09rZT56FZMCCJQ
 B39Ryf625q8ALwyoeZMcUIpu4Cx0b00sFIiR0ArvdR4Nse6y4tbD9DQjRX3we2ExqTb5t/oZxe2
 IJxzbBexuHz8/ZYNTo0j7bqq9y59LeW4FxaS2RvTHuzdGP+dh+O15nSMUZqR6utP4kn2OEok+Gl
 DALqgIXYm01p7+d56a38laVVxb+mQtL32yYcbyGk7mgb5x8MEKv2f3rNTnjv10cxIxIC1DyL9NP
 ND3w1NhcjVFZhqDQS6bc5+5xxly4Ez/Li5y+U7t/cgcOwF4mde6KUDRzgg0qF2jQEUv2FGK5pN4
 Oh5nJf4gW6iwSJ7C1fg==
X-Proofpoint-ORIG-GUID: o1FWPs8ifk418wAElF_1gvHZCiXVeijS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA0OSBTYWx0ZWRfX1/tVzfod4L1N
 +fHcv+JWt4o6Ym/GLkDFKAG+40Uf8Ed1gZqk/Z7I07JtrJsDcArx4JJ13ZR2cxqcrWOs7AkKr76
 B4vYRgve3pSAdQYJ//4Zd37apZ/SQ3M=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae48be7 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=KvRoaEZvRM7Zw1c8dV4A:9
 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300049
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aswin,

On Wed, Sep 2, 2026 at 7:08=E2=80=AFPM Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Enable CONFIG_MMC_HS400_SUPPORT in qcom_defconfig to support
> HS400 tuning and DLL calibration.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Tested  on Agatti (Uno Q):

Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index c52f619850d..15a83c6ce9b 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -100,6 +100,7 @@ CONFIG_MISC=3Dy
>  CONFIG_NVMEM=3Dy
>  CONFIG_QCOM_GENI=3Dy
>  CONFIG_I2C_EEPROM=3Dy
> +CONFIG_MMC_HS400_SUPPORT=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_ADMA=3Dy
>  CONFIG_MMC_SDHCI_MSM=3Dy
> --
> 2.34.1
>
