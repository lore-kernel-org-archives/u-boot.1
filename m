Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A86606A31F
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OhIROLCd;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EkXKLqOb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUV9alj6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5909F60648;
	Fri, 23 Oct 2026 14:14:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fl2KC8-CDvNl; Fri, 23 Oct 2026 14:14:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 489B560689
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792764881;
	b=k9WXiSb1WbwREJa+EGFk41O3VhkHMZF/L5iYGGPs9bxdfCreHk1SzUo//xks8iYcDVtN
	 /QUdnRc4sGsKGkqdFsF+rqhbjzfeWSzh0aUmTnGRHISILw2Knd3QnAkgnQELKsRseVXcr
	 5LrUBxdFCQgNlBy/+H/6sYTYEPirhDMZrqvD1uNDQQwEY6oX3VEfkaPP4vbksP9QkTrKz
	 jTqeQTfcbX2kly79LIxUPPiHpqj0TQSQ28bj7pEhJEhhg5fvSklvvHq0BL2Fptm64icq/
	 JN9PpbQDWqvjW7yric9iW3yoUTnjLjWtmg2rXhvhKbGhuCRv/BNjG/C46S9VsI4g3ng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792764881;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4NeQTKjcxzmdtaKuF41Luoyp4iP2P6gsafK1t7Jz084=;
	b=rMGSNVT4AXExXpZZ+7Bw6+sUPSrKVAtox6RBrc8lvDKeDIwJ5j+h8JgJPBEVLkKl5VVy
	 VIqqHf9pqpUy51UsX3QsO5ltMOd/xp9YkFsQicixNGXGa+Gn8mUwzp7JPDNPEnj5YxElD
	 KCbWgg7R6o2/w8Png0E3gnGRyzWGuZJfUjDG3vnuqAFvDqK/jLJpR0+KTrcIAJ3JyndCQ
	 0IAujCDkLM3B65nX58Jt+W39lQcbGZykiKlmrR3rGtqp+Ses/Nrncq7H+oQR4xKbsH2oR
	 DmX0zYJAYt8sNkq0gh/Bnn8w6NSKgMug4EYRS7ulZvoxy00b9KejyiVGjPMuS7d1Siw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EkXKLqOb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUV9alj6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792764881;
	bh=4NeQTKjcxzmdtaKuF41Luoyp4iP2P6gsafK1t7Jz084=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhIROLCdR6+6SKDhrb8AKQYsEX7QGMv17wP6Q8ex2WukmpVLejK+8qEfiOTPoQR3D
	 a9Q6S1NWUWnzawq1u12xGgoTz50Xwi0JitRRiG0LiZ9b2hhG4AdLxYjBWyDaaWNma/
	 Kvp6GqMgy7zjECD7b+m7vTLYanZlNxw0UMhpiWnMlMq0W3We0xnwwgemoYy8kUjFj1
	 YqlotWifvPbdZClOtaTC31IdgTjF1Lo6sZ/fTbbTUNnfF4YpDC5dv8vPwVht5h1Kf0
	 WaMqBtQkLvWC6hhYjLQY2Tuy6vRjXjXR8ckU4740SEmAzr9Ywqx8l9Jwkp7YMd+p0z
	 R++T5H/0LI4gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 489B560689;
	Fri, 23 Oct 2026 14:14:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFC533C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91D5660648
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-BU3ZB92NBk for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 14:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA8D7605DE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792764876;
 b=QYCEv521m2IFJ61fTwkDKdNmtFYcAUwmUf/JiCKNhUIWRJKLPQ4m6HTTBXoQCSdt3fXG
 R//OOY5cCT4PzeYGlfCdLkTjQ51uvvwSHD0/p+yxObELL+xaWgEzi4z6nhG1o9XjeSyf5
 XgYE6pOxh/mQ3ahZM5i38KB+0UtvFECdU7VqG7cU4FtSogdybLx8d5QlaLyJqX8YNL4Gx
 esMaV6urhdQLfnQ5bPc05MF7D1QxLB3/0Gp74uDauPoZ1y/JKHFLYc4R+biEtA4auQd8k
 PQ5PiWywL6mWYav1ij0AkBgc34el8iYrgMQjT1wAlSiNQHd9KXhxOPZ8PBIcg9i7VYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792764876;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=4NeQTKjcxzmdtaKuF41Luoyp4iP2P6gsafK1t7Jz084=;
 b=iNnyZ/cEK6DjT5crgrC8iIA000p1RuDpZAY5oPlEV21t4tF3gA79DhwVHsBpPKySWJqG
 sSEMCrew1hjYSJHykz0BOiL0bt/FMzSD2PtWYCMCRvMLbOCO7LxxMpIq3GX8IIsfMQUtt
 8qBCvk55wNCABw4BoJrZ00OVjbUTZbq5fcZZyYvbRgrqmEyW/LZPflH01zNQtmKzFVuRv
 oS8vWZNQDu+QK6FcAWIfXv+2hQW3UCVzwwMWqQojWYCShFoPZn7g+DL1gTLngSyruFjVw
 SlygsZ5aClo39ZIB1vT70gczXj9N67EdAPFtZLnd/62iP3LCjJFAwXg2vlD4PcaKSBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EkXKLqOb; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gUV9alj6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EkXKLqOb; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gUV9alj6
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA8D7605DE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:14:35 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5sqF4072757
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4NeQTKjcxzmdtaKuF41Luoyp4iP2P6gsafK1t7Jz084=; b=EkXKLqOb6Y2mJEWg
 aKQ8JgqYxHIW30GZoctlBF0Vko7qGtzoWcO1mzbr+DlSfPYJumzF8TcHyNxA9Wz3
 MQ8DqdGxVaf2vZPSdc/GK8xwq6/TpXfZGJDySgUjITWP7bjo2oO/3lV5uQpE7d92
 KmKC+hLlhwlRLkXVqc+6I11oBut9vEs5qsQQwHrEvdeOdqdrz94euA0BbyGJw0Nx
 33WOS55VBbPXi0Nv7hm+qCPxmizzThVvJ/8QQ9xSGv+8U/30GIl5YsiodPn+7RMW
 l28oi+Y+Av/mwFbeD/GhPIWLj7lHZP9sjX8Uzexdt4hG/xrS+clr6loM5XG8z9xt
 aaI0Sw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7bw0esj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 14:14:34 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b0c6e715e2so16001837b3.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792764873; cv=none;
 d=google.com; s=arc-20260327;
 b=K8Z7IeWmzKjgyeXfHEWCK/BLus3nnrpuyVaa1FFqvZIfLuKlaZZOJlJPK6DWpEEg6D
 63QOKPnycRnOMPTxiSDMORT7R/d00W3O74ZouGTvUd0WW/cq9SmEud8RtY7AMTl3meR0
 XBNzMHSMmlUW7fypHlrELwcRdcxeJh7C73fU9eSzzK+TWri4CwNlUgnSmhBL1UYUi7Ee
 Mzlmjfnr9kqJX1qfYB6Iv1ZWpvrPYWBq3sEtFkDf4LMQ75LhbRlcYgxBA5cpmt84ol3t
 nAQpYmUFnbGW8lMbGSToGW429aVt/H0LuVnDz6XMsUp8VpO727IIhsvIM0m0lNoFeb03
 /gHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4NeQTKjcxzmdtaKuF41Luoyp4iP2P6gsafK1t7Jz084=;
 fh=6K5xUVrcqghEqQcf6k2PB36txJ+69dNH4I1eeOlWgZ4=;
 b=iBwcDoAJpaO0PGsK1oksEQkI5Sl0PtPsdvjQIw6BXF4tM57oc9F3uw7Tg2jJv+Ksbs
 4DyXw68apK9pLuuR+ZBMSMdVuA+0oIJbtkhcR1eD9thI/sR1IAkuGyfwqy4XRayaFrRT
 7wAl/t8o++LT0fVSO+8taZDxNMntbLAeq0yODnWkdlJOvUwbUQcx1FoyVNJvPLhaxnGX
 4eLwA8KiX2uwA3kKxLfVCHvX8gYLK2OtfbRnwoq+Pumd5GktwWJZ2N6TkYwjcPzsLLdr
 tYUV6XokNzY7hJzpIKfv8dvS04SYyasbps4BUCwyiP9TXfYNYHnU8ocV2T0CIgKyK1Sw
 Pj4g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792764873; x=1793369673;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4NeQTKjcxzmdtaKuF41Luoyp4iP2P6gsafK1t7Jz084=;
 b=gUV9alj6sHpkItzDsk9CmPo++wXD7/VC1YAr/U852887HwVvyW6L9Z6/Rjf8z/L/jI
 4NCEE6WvRp3nu8fEDe4kQe42z/QFAZWYrTBrXoq+gMG8SUY73aVWHs8SP2KReZcXMGeC
 Y4QMV3BpT1T5t78lZaPD2COTwv5ALqFX55sLx3HzGHlfPEb6UQYbDY+4ozhcmRcn47ub
 3v3RRjnfQQmAtBnPdE1g/TxBSKQxqO1VXZLRaaQ6k7+eGWilky6ktRq2EtbNSmaQad8r
 0nmbzPVQR2HVuuIcCBMVUk7tYEc1bBj9I+kW3G6GJmDotvDt3aTqclLx/DE3eMkFM+5X
 pc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764873; x=1793369673;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4NeQTKjcxzmdtaKuF41Luoyp4iP2P6gsafK1t7Jz084=;
 b=ZmNqyVXKnEu7AAQGIr4jrETDze3c3t3lZi+HJZuESXBK7+8zDLw0Yug9iuCVobOYGO
 +8H4FDLYSj/aWZlTF2C5vQBvp/uCXDW8cyC/RZ2lH/GTEUV7OCPjBA2/o+O6/0hvtOU4
 hRrUBjK3RSA+s6Guh09KRC0ov9rEJdFd+VuMMHxXA+OcZ5FYs+H4MeaF9UsuVu5Bqtam
 uuhNhWR54GpnaX0EO44oW3V962YM0DW0XhScDIX4FJsmVEUlgR0+NCo36wu7NtdlskK0
 sfK7M6J5BTvTTIpV1NWyULuV5JYUEEzvU6K5NuSgvbpmjyd1qbQ1S8jO/QXZV6hHenZp
 f1LA==
X-Gm-Message-State: AFq9FYIgfJxUovQcSJ59gaQQTWSc+SYIS3ni+l2MZroarsCO7kX9nJnw
 xqwgCx28TN0afV0tnegBCMiogONo9x9gToJoA6aPGUuyD57sYCvv3xqZWWPQRslEiHUc/5Pk+px
 DT67FoOjr37deKNVxe8hKkinHrp/uBCkj/39dc6kIkT8v5ZrT5daHocz4Cl4hrSdW1Mo+2Vt2As
 eKsnIw1B4Gae8fCyq5TgGq96FScqC2rnoTjFZ0thVP3KRK3w==
X-Gm-Gg: AYBFou3W+zotnVSk2KM3sTx+Oky16c3qkaBRzyYA65Aj8fdaD2yj5dYlCUQNHF/T9Fm
 ELqUJlWQHEarYcIDnMuVGkpwFJWpicE0w8IcoGlktq6/qhfs388rz+9PEo0cW9S488XFx7FWatj
 zaq71MBl0Jm7NOWJ4XeDdKvgDrMtfJ5PoOZBk2cGFxrUN3/KU4YAXVJw9n6zY=
X-Received: by 2002:a05:690c:c4f1:b0:8b1:55ea:c6cf with SMTP id
 00721157ae682-8b157e89717mr16387607b3.52.1792764873339; 
 Fri, 23 Oct 2026 07:14:33 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f1:b0:8b1:55ea:c6cf with SMTP id
 00721157ae682-8b157e89717mr16387337b3.52.1792764872792; Fri, 23 Oct 2026
 07:14:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
 <179275217876.886736.6937155990522210284.b4-ty@b4>
 <xhkdb1p9gps36.fsf@mkorpers-koolstof.csb>
In-Reply-To: <xhkdb1p9gps36.fsf@mkorpers-koolstof.csb>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 16:14:21 +0200
X-Gm-Features: AclHuK97ItE6FV0MEU-8PBK4JyIOF15cDadTXr0D2hBGJ3K3CflfCrnFkcXVJsI
Message-ID: <CAPzfCAYie5VhHEXvF3pzV60Nt52ypdjGuwVRXRehV7XdabDTOA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] avb: device lock state, root key provisioning and
 in-place verification
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: W2RzJDNFkCUZhB7UuZAxBp2Mw0kFvl9O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfX2YotYovOEJvt
 OEERAnwGS1Um8NH1TBuhHusB5yKr4RTkPlq7JWidsSgRF9NZcXUqlPWgWCnTJZIf0+hBs9/JF6Q
 Z39Hm1Y2eKna8AwfFFkErGP0W4ZypnU=
X-Authority-Analysis: v=2.4 cv=QdTzLcbv c=1 sm=1 tr=0 ts=6adb6bca cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=1VxDqnHFAAAA:8 a=5p_tG3gqAAAA:8 a=voM4FWlXAAAA:8
 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=ujd4atfP4DY4yoHViYMA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=aZ5uHUMKh6B-zo3GvD48:22 a=IC2XNlieTeVoXbcui8wp:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: W2RzJDNFkCUZhB7UuZAxBp2Mw0kFvl9O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NSBTYWx0ZWRfXxhBt0IHHBNDD
 NaxsYiMLPXz/kldMZ0aLPh0yBrRu3aVC2GlHgG1wARnn63jELWRm1SD6Y8Y2ktv+VWAQlTw2zLZ
 T5s9+XaPOiODOZGZR9RyJ+LpsLTtU8ZxPOY07WaA/V3I74b07n0Tw8QQGWAApiyatUMG9XT+afi
 KWAE4rs32Ovidm4VMx9B82ScN5tbFNqvtDdbsmm9Svdb6iUQNhGTR7ikFZqTyWjWf7/FOOAdsaF
 zYwCqpuuwP0KM9pzG7k6G6fMYc5hBSTKF1Q5WhZgScto94lQHguOv6rqkJb9o48u1oyb0agOw0G
 ii32zrerNQ0EXSqfqlGcXw9+xYZ6mb5vbYSqgEfZHzGAx5ogO8JJt8xWNLB7+KROpfrwAe37Fln
 E/s/zRhfhxbo9BtEowT3ORjAoR86ldgUdLGqxiP/fO1SnuoVcNW49TIu1uWf3vL0Hml2YFr2yLq
 GQTDD5gIhr8i+KtyKXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230055
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On Fri, Oct 23, 2026 at 1:35=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Igor,
>
> On Fri, Oct 23, 2026 at 12:42, Mattijs Korpershoek <mkorpershoek@kernel.o=
rg> wrote:
>
> > Hi,
> >
> > On Thu, 22 Oct 2026 21:04:41 +0200, Igor Opaniuk wrote:
> >> This series completes the device state handling of the AVB 2.0
> >> implementation when the state is kept by the OP-TEE AVB TA, and fixes
> >> the way the Android bootmeth hands the boot images to libavb.
> >>
> >> Patches 1 and 2 add the shell side: "avb read_pvalue_hex" and
> >> "avb write_pvalue_hex" provision binary persistent values such as the
> >> SHA-256 digest of the vbmeta signing key that CONFIG_AVB_ROOT_KEY_TEE
> >> consumes, and "avb lock"/"avb unlock" set the lock state through a new
> >> avb_write_lock_state() helper. Until now U-Boot could only read the
> >> lock state, so a device backed by the TA could never leave the unlocke=
d
> >> (orange) state.
> >>
> >> [...]
> >
> > Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-b=
oot-dfu (u-boot-dfu)
> >
> > [1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/com=
mit/ae7f94107cf9a1a83799034b1e4165fe49e6d8a7
> > [2/5] cmd: avb: add lock/unlock commands
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/com=
mit/08d45d705a740c63791441f4b8e0a612dddf15cd
> > [3/5] avb: verify the boot images in the buffers they are booted from
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/com=
mit/5f6530505fdc0fc01f2df1363febc338fdfbf709
> > [4/5] fastboot: add flashing lock/unlock/get_unlock_ability
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/com=
mit/c69982f9c9ec2b3f2d91dc9c49e9971f9fe3664a
> > [5/5] doc: android/avb2: document the root key provisioning and lock st=
ate
> >       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/com=
mit/2d105e34525ff9b0c3ee8c434781e5c9ff807b4d
>
> This series fails CI on sandbox_spl test.py:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/123953

Yeah, my azure's sandbox_spl build
(https://dev.azure.com/igoropaniuk/u-boot/_build/results?buildId=3D47&view=
=3Dresults)
passed, but unfortunately, I tested it on the wrong base: U-Boot next
plus Jan's v3 patches (which I rebased on),
without Carlo's SPL fastboot patch [1], which recently landed in u-boot-dfu=
.

I'll send v6 in an hour.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20260913-ccaione-upstr=
eam-spl-fastboot-v6-5-dd3ba81a7ed2@baylibre.com/

>
> """
> Building current source for 1 boards (1 thread, 16 jobs per thread)
>    sandbox:  +   sandbox_spl
> +drivers/fastboot/fb_command.c:302:13: error: =E2=80=98boot_image=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
> +  302 | static void boot_image(char *cmd_parameter, char *response)
> +      |             ^~~~~~~~~~
> +cc1: all warnings being treated as errors
> +make[4]: *** [scripts/Makefile.build:272: spl/drivers/fastboot/fb_comman=
d.o] Error 1
> +make[3]: *** [scripts/Makefile.build:497: spl/drivers/fastboot] Error 2
> +make[2]: *** [scripts/Makefile.xpl:552: spl/drivers] Error 2
> +make[1]: *** [Makefile:2462: spl/u-boot-spl] Error 2
> +make: *** [Makefile:189: __sub-make] Error 2
>     0    0    1 /1              sandbox_spl
> """
>
> Can you have a look please?
>
> If you resend a new version, can you also please rebase on u-boot-dfu ?
> I had some conflicts when applying PATCH 4 (I fixed when applying but
> i'd prefer to have a clean pick instead)
>
> Thanks
> Mattijs
>
> >
> > --
> > Mattijs
