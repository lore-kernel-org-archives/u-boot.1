Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B28606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZTtyS38c;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=je9g4cKd;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EwonKwFN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 157FF6088D;
	Thu, 22 Oct 2026 19:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bu3gNQNZVGRd; Thu, 22 Oct 2026 19:05:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4909860818
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695904;
	b=GgxaXPYNUjSYClPbniywTcV3jWNJSVezgO0eePcsZeLEi/gSeuv0hPYT9QrLtzku2C+3
	 0qHdKoxQtdzO37dYbJhhjkXdYTr9m3q0U9lCu1a+fwSJhRGQjl6HAKuZKTFl2Pch4bayD
	 HsyZd2Uaa6aSvCuSEn1alvo9KdY4FJYOKwYL7TjLaIH8Oooa+vDqY4AWonVeILyrxWDud
	 WwNhf8lv6h4uFqXfBnozEZOmQMtqAItWaojudbDItOMayOxkngEVQyO7ecLYuRlxJtobv
	 SDLZAwv3IK3U9J6GK83jsZ4Zi2Jx4PD6dlV6iVqHh38LTXZH0LcOp+MNZxbN266tCXQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IbgxIWm9hegK92dvRAopYUqf0hBmhGhd2RJ/k7ueHnQ=;
	b=NqkHe8pO7mK5YgIz37UFZxfA2M0nZ2gGRqTD/fnu1iBmJHRvYwXrItM4QMZcKWZIgnYR
	 7R5nTUUTGvZHco8nu4N5zEs3uyQs/FfKqGZSiI0xo9gQD3vXnvo86dCSDXB5s9G5kXPdL
	 eBBicG7v34Vw+/oZbzGyhlDF2OgEYernAep1RnrSE5CcSvlrf8AL9TPvfgsYKTU6gVtGj
	 n50zF5wsCTn5rnFxkEu9XagyYd/aUrvKu+LcAvkJ/SCZPG9M61LXGieWv2qsoFVxA5rBm
	 gemshyVLp01NmHNd8ZRJ4RzunqAYkAa2HtoRo0yfO5p8OSSfup1Q5MhPVfsG6n7TN3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695904;
	bh=IbgxIWm9hegK92dvRAopYUqf0hBmhGhd2RJ/k7ueHnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZTtyS38cWXo/xDsmY0lnLdoMjUCveUCa2+fLL7hHSLwm/ihiho0kVj51jf1JmKlxN
	 QiE2qlMDF57igM/QQY6RrwJ3ducjfvVLPKAuKHX3YW1v/mZP6Mh2hFzFD0wuLiDbjZ
	 tbiMUxHkDKEcTNga/XQ2N9traydDjouEji/sUIr5uK7G00FLJl2wyaxD9ko993HT+6
	 IxsV1gYC5HrhPBehAO56nP4gTkc27cl+QcskWvwuhPQ1UOPp3nHnTjxBLC/iENN+H4
	 v78jal1jCI8elDySCv7jcO/9DWvXN/Silro8mGp1esVIatkRt3FOiuI+MzPi7u9TE6
	 2N5i0vF8k3WdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4909860818;
	Thu, 22 Oct 2026 19:05:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 36F6C3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CAEB81283
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:05:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QdZMjDTzyBh9 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:04:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B46FF81271
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695898;
 b=l/piRRJvQSzt63jYA1WgWJdLib3NzWXWTzPFP+9Z3QFycS2USveyOY5iZrKQAbWGbycU
 kxMFrfPhpkBzBgyJggnBDGKuPYlfuLnXhQcxxPU9QcED/brQpsxTM4bqHMxxw61/oO7lX
 W3utgEPvh4JnG06W5ZaVv49JtuIA/gUbJeLA7FL2vL1LcX5p3lMQVaaCOLK6OtYBsETz6
 hIPZtp3cw5yNjzhXrLZbdFjsC2OQRiSvozW7mZsWpEMi6FcZghwAhRig1aXCErEUAcoPP
 7AoIpozt7wV7y1ung+S7Pg0iDEJCb8rjmP6PsnuJdgZec/f8UZPnpSJ0o4w/7elgtJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695898;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=IbgxIWm9hegK92dvRAopYUqf0hBmhGhd2RJ/k7ueHnQ=;
 b=cgyurYr49bZPVe37GjBCEXQsrlKAi9/+6PGuP2PBxsmysKBeDXUbSZy6iPGP9ZRuvhwH
 zYEC9NZOHBOvbmbAlThhnlb7enteHg2UZCg0zJ2HRFx+wkKXvgBa9ozVTSYVctW21kSjH
 vmS6Skl15GpCP/xuVGidMP1FYs3ukr7i5efSrfX9gvR35wACGcN6J+iXEE3pEDLUs7X9L
 MpCvqyjvSN1hb/s499DIiYvqLFnBseQ8CVJ2AZr9OWQ3ZbpCD9b1wxhmWQPDHJfRLS94V
 4aP8hAE05ZbKwGB8gN2gB9kXVenKiLC7Nq5NOoX8Q2BZ/2iXuuI5TmfH7rO0Ndk8mpg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=je9g4cKd; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EwonKwFN; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=je9g4cKd; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EwonKwFN
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B46FF81271
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHbGd3742132
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IbgxIWm9hegK92dvRAopYUqf0hBmhGhd2RJ/k7ueHnQ=; b=je9g4cKdePlwkSeF
 fEMdWXNjZVzqnMe4k7PArUvgzuizWBIpVyS6jmZwne5Ssd7J27mCyoonIJ2d+RFo
 lLwvLbCLerWnGPuUqKeZsHb5nQEA42ooDSf9jE1JdTErocYvAdmduBPAAX7pC+I/
 ngttCBSwPcKja06UYs+XwAnJHtivqLUUiBgQDoZ+QTozqDKJeUFuWn3HHavxkUIO
 Fu1zDD4uLiEPHF/UkEDwv9j7YxC4YgVxjUnCJzoupqcLusNjy8RcxQGm8EkEGq9s
 NN8LuU/nr37GyYMgBso5EXwNHHpZ8guE5xYyh6eZXXJSeaGNP+YrElaTd+Xyz3eb
 mwpUpA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms05jf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:57 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f322ef7d3so26846485a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792695897; x=1793300697;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IbgxIWm9hegK92dvRAopYUqf0hBmhGhd2RJ/k7ueHnQ=;
 b=EwonKwFNcFZiY38cy60Lgamn7fKbN/Hkpk6IiphoyytE+AbdyKWn76yGN64IK9a5rZ
 iZhah7F4lzMfjlcGzOg1HVtl5ex56eOOCbIDfs9nLACWp+UTt/y/8rebrbNZSI80tXVC
 TU6uQYfh1ZFYDBgJ4i1KZSTyN1gzUenzLHIg/vNelf0dPPmJQKLgqkHup+sSG29dWkAs
 ITUzYCpqgq2QrOYlz82YdcnZvobnBvOmEC8ujvf6pmaQ9kOUvNyH53I71Mj0cPCtK5rb
 Aj9vfWjryOPTqSgf2hwueXHH5pc0AejhXz1DrmM6rQEfpoDSXifd9TB7BcSETpE3OpHf
 l8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695897; x=1793300697;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IbgxIWm9hegK92dvRAopYUqf0hBmhGhd2RJ/k7ueHnQ=;
 b=H+OP0AszqK2NgAm0+OA17CVdvaopVTZ2JehJPHxP8OiATf7J4fiOu90pSvSVeprWg9
 MkkIhAPrAWhSaSaabOdBf5KrDOYUO/qtN0vBiv0fpt85F5xoT88XDhEyIY9lBXAKZfLL
 IcqdyJ2egIhEA5J2uicZuEdnbx7NG6muAmfIGgN7xQPJ5DD4lgE2qUo8cuJBgYV78NFu
 P/0B2Ir9de/rAHwytVP9/hIabcmpytQHcJGNl7wyeZo3H1ZdWkvUEYe6G0upyrmNBg7C
 rEb2qKKZcoxIjjU9dER3MywH+Jw1XlkkANpJigAz8TCm8yCH1fg5S/sWKG7XvO2JmB+E
 uikg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXmlZQIpvX1EG7l/GiWJaENjZaIWSBk+l5A8+HZHa835B5zPNrWxipdDbVwFpXEqOO2XWb5GQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJuic9b+gY3MrGc82lZDGljoGYQgCQVn+8O2KduNl6H0p88nHp3
 +bsdMym/AWs9FpiSE7bXk2MFCdryOrsaO3P6szP59zXV+K65tFzRMO/Cw4EuVZ0p5JhFnL/UAGG
 ow1qog/vF64lMA7qMkkw3GbCpWzZBnty7W4MNre4FTF7EsAuDQ3nuQAewaWpbSZrKkB8fDx+265
 d6XUw=
X-Gm-Gg: AYBFou0TOGb87iC4LQw8J81AT8Swy5XVKHWXYDd9Twq6pxWXFnAmMUUziVpbLeaJWiN
 zUMjirW0EsUD5Wnym8/aMG3nd8wEIpOpYK2ePHHn5rfNi2YIdp82E9BK1oeXCWrAAvhXDyX9S2r
 JTMC6qYEL/qB6OpV/kLAF33+kSNbR3mq+Z/l80SdRz0n9VjAb9SPJ6ujcFsMhFCVSvbNwE7oH+G
 VGcvLilnp2qLWpBQETnChSdcuXyE0Gf0T8IoyqY17WywV+p7WiMp2PGH1KDTqfZIwyZDAN5T0WB
 252UbBf0fHag7J7metL3NFoeCi9kblRy4noNUsKUFMTg/e5HAhZh92xDplWnlVtjwILrfHf8laP
 uyYih6kqZeT+FwHTZUOpyxORo+QYxm1VwNo4qB6G7pkdO
X-Received: by 2002:a05:620a:3721:b0:93e:910c:5fbd with SMTP id
 af79cd13be357-93f6f82b792mr70510085a.63.1792695896341; 
 Thu, 22 Oct 2026 12:04:56 -0700 (PDT)
X-Received: by 2002:a05:620a:3721:b0:93e:910c:5fbd with SMTP id
 af79cd13be357-93f6f82b792mr70502585a.63.1792695895668; 
 Thu, 22 Oct 2026 12:04:55 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c8295fsm18914666b.36.2026.10.22.12.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:04:54 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 21:04:45 +0200
Subject: [PATCH v4 4/5] fastboot: add flashing lock/unlock/get_unlock_ability
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-avb_lock_unlock_b4-v4-4-f4926ca925e7@oss.qualcomm.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
In-Reply-To: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jan Kehren <jan.kehren@emteria.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX+Os8dSDMPwm7
 vkOpdB5geC2YMXOD71PF3tWycKkOBVwJZjt+1S9D1ZSZQwUhNpwd2KCvV6Ki6XdUnwNk1+UM7gl
 vcVP7qmZeDSirwOPF3yXInpKKwmRQr8Kp0KOMDHsNhw0ciCNANOw5YZEo5MKfuIS5BQUShfvYPC
 Ecj5oaF8L4VpTo4a4TXM4AP1f0ghRQIkmjc78kSAC025CHF43q6oNcTz5RQgOJFDaAxk8XQvOm1
 ue7XXmIjcE+S8DggzrETt2Qk7WV2NqL+YtfzxnIvI8X9yIUZgbOLD6HpT0TfZ0+OhiQ8EATYlSw
 WDmXkR5H9JRSFauiTxa0giKdUNrh4vOzFVpPBjwFRKXA6IAHM7NnDrEV5MeYHhx4l+ya3Uf8plR
 /UV7XZQlkYE+nFQ3Ze9Uxcn11RgHkzyZ6iLrXVUIc/3Xr85dtjqLzYU2OdjalhpvusuSd0PAHrK
 Taf4Q4ArvfXtKW/jLvA==
X-Proofpoint-GUID: hihbWISSEv-H6dbAWr26-Ce60GS3iQR8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX/AmhQrJJ4t7l
 Bkkp2tyuZqQEC6RV+bTADi2mwq8Yot+Nna3oIMSKz+GwjH8tbZch5Px2B7kl9DAlD2PZYSdeNJb
 GGUwMGWYZaSzcpXGZH+SbGRqUB3345s=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada5e59 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=5JHqtTIscBY7JO8zqbAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: hihbWISSEv-H6dbAWr26-Ce60GS3iQR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220076
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Android's fastboot client changes the device lock state with
"fastboot flashing lock|unlock" and asks "flashing get_unlock_ability"
first. U-Boot has the state in the AVB TA (avb_write_lock_state(), used by
the "avb lock/unlock" shell commands) but no fastboot front end for it, so
a device could only be unlocked from the serial console. The state also
had no effect on fastboot: a locked device still accepted "flash",
"erase", "boot" and the oem commands.

Add the three commands and the "unlocked" variable behind
CONFIG_FASTBOOT_CMD_FLASHING. As AVB requires, both transitions erase
userdata (and metadata, which holds the file based encryption keys) before
the state changes and are refused when a partition cannot be erased; the
TA resets the rollback indexes on a state change. A device that is
already in the requested state is refused without a wipe. The erase goes
through the configured flash back end, like the "erase" command, and the
lock state itself lives in the TA, so nothing here depends on the storage
type.

While the device is locked, the commands that change the storage or run
code are refused with "device is locked": "flash", "erase", "boot", "oem
format", "oem partconf", "oem bootbus", "oem run", "UCmd" and "ACmd";
"flashing unlock" is the only way out of that state.

Unlocking follows the "OEM unlocking" developer setting the way Android's
PersistentDataBlockService stores it in the frp (persistent data block)
partition, looked up on the fastboot flash device of the mmc or block
back end: the SHA-256 digest in the first 32 bytes of the partition must
match the rest of it (Android formats the partition otherwise, which
clears the setting) and its last byte must be non-zero. get_unlock_ability
reports that and "flashing unlock" is refused otherwise, so a device
without an frp partition, or with a back end that has no partition table,
can only be unlocked from the U-Boot shell.

Tested on QEMU virt with OP-TEE over "fastboot tcp": unlock and lock
erase the partitions and flip the state reported by getvar unlocked and
"avb is_unlocked"; flash, erase and boot are refused while locked; unlock
is refused while the OEM unlocking byte in frp is clear, after the frp
digest was corrupted, and on an unlocked device; lock on a locked device
is refused without a wipe.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/fastboot/Kconfig      |  19 +++
 drivers/fastboot/fb_command.c | 362 +++++++++++++++++++++++++++++++++++++++++-
 drivers/fastboot/fb_getvar.c  |  22 +++
 include/fastboot.h            |  14 ++
 4 files changed, 411 insertions(+), 6 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 1887f78bcec..59679e5c009 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -248,6 +248,25 @@ config FASTBOOT_MBR_NAME
 	  specified on the "fastboot flash" command line matches the value
 	  defined here. The default target name for updating MBR is "mbr".
 
+config FASTBOOT_CMD_FLASHING
+	bool "Enable the 'flashing lock/unlock/get_unlock_ability' commands"
+	depends on FASTBOOT_FLASH && AVB_VERIFY && OPTEE_TA_AVB
+	select SHA256
+	help
+	  Add the Android "flashing lock", "flashing unlock" and "flashing
+	  get_unlock_ability" commands and the "unlocked" variable. The device
+	  lock state is the one AVB enforces, kept by the OP-TEE AVB TA. While
+	  the device is locked, the commands that change the storage or run
+	  code ("flash", "erase", "boot", "oem format/partconf/bootbus/run",
+	  "UCmd", "ACmd") are refused. As required by AVB, the userdata (and
+	  metadata) partition is erased before the state changes in either
+	  direction, and the TA resets the rollback indexes on a state change.
+	  Unlocking is only allowed when Android's "OEM unlocking" developer
+	  setting, kept by PersistentDataBlockService in the frp partition of
+	  the fastboot flash device, is enabled and the partition's digest is
+	  valid; a device without an frp partition can only be unlocked from
+	  the U-Boot shell.
+
 config FASTBOOT_CMD_OEM_FORMAT
 	bool "Enable the 'oem format' command"
 	depends on FASTBOOT_FLASH_MMC && CMD_GPT
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..5e8d243cb80 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -12,10 +12,16 @@
 #include <fb_mmc.h>
 #include <fb_nand.h>
 #include <fb_spi_flash.h>
+#include <memalign.h>
 #include <part.h>
 #include <stdlib.h>
 #include <vsprintf.h>
 #include <linux/printk.h>
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+#include <avb_verify.h>
+#include <blk.h>
+#include <u-boot/sha256.h>
+#endif
 
 /**
  * image_size - final fastboot image size
@@ -33,6 +39,7 @@ static u32 fastboot_bytes_received;
 static u32 fastboot_bytes_expected;
 
 static void okay(char *, char *);
+static void boot_image(char *, char *);
 static void getvar(char *, char *);
 static void download(char *, char *);
 static void flash(char *, char *);
@@ -47,6 +54,14 @@ static void oem_console(char *, char *);
 static void oem_board(char *, char *);
 static void run_ucmd(char *, char *);
 static void run_acmd(char *, char *);
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+static void flashing_lock(char *, char *);
+static void flashing_unlock(char *, char *);
+static void flashing_get_unlock_ability(char *, char *);
+static bool flashing_refuse_if_locked(char *response);
+#else
+static inline bool flashing_refuse_if_locked(char *response) { return false; }
+#endif
 
 static const struct {
 	const char *command;
@@ -70,7 +85,7 @@ static const struct {
 	},
 	[FASTBOOT_COMMAND_BOOT] =  {
 		.command = "boot",
-		.dispatch = okay
+		.dispatch = boot_image
 	},
 	[FASTBOOT_COMMAND_CONTINUE] =  {
 		.command = "continue",
@@ -128,6 +143,20 @@ static const struct {
 		.command = "ACmd",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_acmd), (NULL))
 	},
+	[FASTBOOT_COMMAND_FLASHING_LOCK] = {
+		.command = "flashing lock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_lock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_UNLOCK] = {
+		.command = "flashing unlock",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING, (flashing_unlock), (NULL))
+	},
+	[FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY] = {
+		.command = "flashing get_unlock_ability",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING,
+					      (flashing_get_unlock_ability),
+					      (NULL))
+	},
 };
 
 /**
@@ -210,6 +239,19 @@ static void okay(char *cmd_parameter, char *response)
 	fastboot_okay(NULL, response);
 }
 
+/**
+ * boot_image() - accept "boot"; the downloaded image is started afterwards
+ *
+ * Refused on a locked device: nobody verified the image.
+ */
+static void boot_image(char *cmd_parameter, char *response)
+{
+	if (flashing_refuse_if_locked(response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
 /**
  * getvar() - Read a config/version variable
  *
@@ -339,6 +381,9 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
 		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
 					   image_size, response);
@@ -365,19 +410,27 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  * Erases the partition indicated by cmd_parameter (clear to 0x00s). Writes
  * to response.
  */
-static void __maybe_unused erase(char *cmd_parameter, char *response)
+static void __maybe_unused erase_partition(const char *name, char *response)
 {
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
-		fastboot_block_erase(cmd_parameter, response);
+		fastboot_block_erase(name, response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
-		fastboot_mmc_erase(cmd_parameter, response);
+		fastboot_mmc_erase(name, response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
-		fastboot_nand_erase(cmd_parameter, response);
+		fastboot_nand_erase(name, response);
 
 	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
-		fastboot_spi_flash_erase(cmd_parameter, response);
+		fastboot_spi_flash_erase(name, response);
+}
+
+static void __maybe_unused erase(char *cmd_parameter, char *response)
+{
+	if (flashing_refuse_if_locked(response))
+		return;
+
+	erase_partition(cmd_parameter, response);
 }
 
 /**
@@ -388,6 +441,9 @@ static void __maybe_unused erase(char *cmd_parameter, char *response)
  */
 static void __maybe_unused run_ucmd(char *cmd_parameter, char *response)
 {
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		pr_err("missing slot suffix\n");
 		fastboot_fail("missing command", response);
@@ -415,6 +471,9 @@ void fastboot_acmd_complete(void)
  */
 static void __maybe_unused run_acmd(char *cmd_parameter, char *response)
 {
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		pr_err("missing slot suffix\n");
 		fastboot_fail("missing command", response);
@@ -485,6 +544,9 @@ static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
 					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
 
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!env_get("partitions")) {
 		fastboot_fail("partitions not set", response);
 	} else {
@@ -508,6 +570,9 @@ static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
 					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
 
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
 		return;
@@ -534,6 +599,9 @@ static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
 					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
 
+	if (flashing_refuse_if_locked(response))
+		return;
+
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
 		return;
@@ -589,3 +657,285 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
 {
 	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/**
+ * flashing_flash_dev() - block device of the fastboot flash back end
+ *
+ * Return: the device of the mmc or block back end, NULL for back ends
+ * without a block device (nand, spi)
+ */
+static struct blk_desc *flashing_flash_dev(void)
+{
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+		return blk_get_dev("mmc",
+				   config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
+						      CONFIG_FASTBOOT_FLASH_MMC_DEV, -1));
+
+	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+		return blk_get_dev(config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						      CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
+						      ""),
+				   config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
+						      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID,
+						      -1));
+
+	return NULL;
+}
+
+/**
+ * flashing_avb_ops() - AVB ops for the lock state calls
+ *
+ * The lock state is kept by the AVB TA and these ops never read a
+ * partition, so the storage device is only informational: the fastboot
+ * flash device when it is a block device, none otherwise.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: the ops, to be released with avb_ops_free(), or NULL
+ */
+static AvbOps *flashing_avb_ops(char *response)
+{
+	struct blk_desc *desc = flashing_flash_dev();
+	AvbOps *ops;
+
+	ops = avb_ops_alloc(desc ? desc->uclass_id : UCLASS_INVALID,
+			    desc ? desc->devnum : -1);
+	if (!ops)
+		fastboot_fail("cannot allocate AVB ops", response);
+
+	return ops;
+}
+
+int fastboot_flashing_is_unlocked(bool *unlocked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = flashing_avb_ops(response);
+	if (!ops)
+		return -1;
+
+	rc = ops->read_is_device_unlocked(ops, unlocked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot read the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_refuse_if_locked() - fail a flash or erase on a locked device
+ *
+ * A locked device must not let fastboot change its partitions; only
+ * "flashing unlock", which wipes userdata, may be used to leave that state.
+ *
+ * @response: fastboot response buffer, filled when the command is refused
+ * Return: true if the command must not run
+ */
+static bool flashing_refuse_if_locked(char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return true;
+	if (!unlocked) {
+		fastboot_fail("device is locked", response);
+		return true;
+	}
+
+	return false;
+}
+
+/**
+ * flashing_set_lock() - set the AVB device lock state through the AVB TA
+ *
+ * @locked: new state
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+static int flashing_set_lock(bool locked, char *response)
+{
+	AvbOps *ops;
+	AvbIOResult rc;
+
+	ops = flashing_avb_ops(response);
+	if (!ops)
+		return -1;
+
+	rc = avb_write_lock_state(ops, locked);
+	avb_ops_free(ops);
+	if (rc != AVB_IO_RESULT_OK) {
+		fastboot_fail("cannot change the device lock state", response);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * flashing_wipe_userdata() - erase userdata and metadata
+ *
+ * AVB requires user data to be wiped on every change of the device state,
+ * in either direction, so userdata (and metadata, which holds the file
+ * based encryption keys) are erased before the state changes. The erase
+ * goes through the configured flash back end, like the "erase" command,
+ * but without the lock check, since this is how a locked device gets
+ * unlocked.
+ *
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 when a partition could not be erased
+ */
+static int flashing_wipe_userdata(char *response)
+{
+	struct disk_partition info;
+	struct blk_desc *desc;
+
+	erase_partition("userdata", response);
+	if (!strncmp(response, "FAIL", 4))
+		return -1;
+
+	/*
+	 * metadata is optional on older layouts: skip it when the flash
+	 * device has a partition table without it, otherwise its erase has
+	 * to succeed like the one of userdata.
+	 */
+	desc = flashing_flash_dev();
+	if (desc && part_get_info_by_name(desc, "metadata", &info) < 0)
+		return 0;
+
+	erase_partition("metadata", response);
+	if (!strncmp(response, "FAIL", 4))
+		return -1;
+
+	return 0;
+}
+
+/* blocks of the frp partition hashed per read */
+#define FLASHING_FRP_CHUNK	128
+
+/**
+ * flashing_unlock_allowed() - evaluate Android's "OEM unlocking" setting
+ *
+ * Android's PersistentDataBlockService keeps the developer option "OEM
+ * unlocking" in the last byte of the frp (persistent data block)
+ * partition, non-zero when the user allowed the bootloader to be unlocked,
+ * and guards the partition with a SHA-256 digest in its first 32 bytes,
+ * computed over the whole partition with those bytes taken as zero; on a
+ * mismatch it formats the partition, which clears the option. Apply the
+ * same rules: no frp partition (or no block device behind the flash back
+ * end), a read error, a bad digest or a zero byte all refuse unlocking.
+ *
+ * Return: true if "flashing unlock" may proceed
+ */
+static bool flashing_unlock_allowed(void)
+{
+	u8 stored[SHA256_SUM_LEN], digest[SHA256_SUM_LEN];
+	struct disk_partition info;
+	struct blk_desc *desc;
+	sha256_context ctx;
+	lbaint_t blk, cnt;
+	bool allowed = false;
+	u8 last = 0;
+	u8 *buf;
+
+	desc = flashing_flash_dev();
+	if (!desc || part_get_info_by_name(desc, "frp", &info) < 0)
+		return false;
+
+	buf = malloc_cache_aligned(FLASHING_FRP_CHUNK * info.blksz);
+	if (!buf)
+		return false;
+
+	sha256_starts(&ctx);
+	for (blk = 0; blk < info.size; blk += cnt) {
+		cnt = info.size - blk;
+		if (cnt > FLASHING_FRP_CHUNK)
+			cnt = FLASHING_FRP_CHUNK;
+		if (blk_dread(desc, info.start + blk, cnt, buf) != cnt)
+			goto out;
+		if (!blk) {
+			memcpy(stored, buf, SHA256_SUM_LEN);
+			memset(buf, 0, SHA256_SUM_LEN);
+		}
+		sha256_update(&ctx, buf, cnt * info.blksz);
+		last = buf[cnt * info.blksz - 1];
+	}
+	sha256_finish(&ctx, digest);
+	allowed = !memcmp(stored, digest, SHA256_SUM_LEN) && last;
+out:
+	free(buf);
+
+	return allowed;
+}
+
+/**
+ * flashing_lock() - lock the device
+ *
+ * Verification errors stop the boot afterwards. The AVB TA resets the
+ * rollback indexes on a state change. Locking needs no permission from
+ * the OS: it only takes privileges away. A device that is already locked
+ * is left alone, so userdata is not wiped for nothing.
+ */
+static void flashing_lock(char *cmd_parameter, char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return;
+	if (!unlocked) {
+		fastboot_fail("device already locked", response);
+		return;
+	}
+
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(true, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_unlock() - unlock the device
+ *
+ * Refused on a device that is already unlocked, when Android's "OEM
+ * unlocking" setting does not allow it, and when userdata cannot be
+ * erased.
+ */
+static void flashing_unlock(char *cmd_parameter, char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return;
+	if (unlocked) {
+		fastboot_fail("device already unlocked", response);
+		return;
+	}
+
+	if (!flashing_unlock_allowed()) {
+		fastboot_fail("unlocking is not allowed, enable OEM unlocking in Android",
+			      response);
+		return;
+	}
+
+	if (flashing_wipe_userdata(response))
+		return;
+
+	if (flashing_set_lock(false, response))
+		return;
+
+	fastboot_okay(NULL, response);
+}
+
+/**
+ * flashing_get_unlock_ability() - report whether unlocking is allowed
+ */
+static void flashing_get_unlock_ability(char *cmd_parameter, char *response)
+{
+	fastboot_okay(flashing_unlock_allowed() ? "1" : "0", response);
+}
+#endif /* FASTBOOT_CMD_FLASHING */
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..74e7a4487bf 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -28,6 +28,9 @@ static void getvar_has_slot(char *var_parameter, char *response);
 static void getvar_partition_type(char *part_name, char *response);
 static void getvar_partition_size(char *part_name, char *response);
 static void getvar_is_userspace(char *var_parameter, char *response);
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+static void getvar_unlocked(char *var_parameter, char *response);
+#endif
 
 static const struct {
 	const char *variable;
@@ -87,6 +90,12 @@ static const struct {
 		.variable = "partition-size",
 		.dispatch = getvar_partition_size,
 		.list = false
+#endif
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+	}, {
+		.variable = "unlocked",
+		.dispatch = getvar_unlocked,
+		.list = true
 #endif
 	}, {
 		.variable = "is-userspace",
@@ -346,3 +355,16 @@ void fastboot_getvar(char *cmd_parameter, char *response)
 		fastboot_fail("Variable not implemented", response);
 	}
 }
+
+#if CONFIG_IS_ENABLED(FASTBOOT_CMD_FLASHING)
+/* "yes" when the device is unlocked according to the AVB TA, else "no" */
+static void getvar_unlocked(char *var_parameter, char *response)
+{
+	bool unlocked;
+
+	if (fastboot_flashing_is_unlocked(&unlocked, response))
+		return;
+
+	fastboot_okay(unlocked ? "yes" : "no", response);
+}
+#endif
diff --git a/include/fastboot.h b/include/fastboot.h
index b106d617749..ce0d9335b6e 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -53,9 +53,23 @@ enum {
 	FASTBOOT_COMMAND_OEM_BOARD,
 	FASTBOOT_COMMAND_ACMD,
 	FASTBOOT_COMMAND_UCMD,
+	FASTBOOT_COMMAND_FLASHING_LOCK,
+	FASTBOOT_COMMAND_FLASHING_UNLOCK,
+	FASTBOOT_COMMAND_FLASHING_GET_UNLOCK_ABILITY,
 	FASTBOOT_COMMAND_COUNT
 };
 
+/**
+ * fastboot_flashing_is_unlocked() - read the AVB device lock state
+ *
+ * Available with CONFIG_FASTBOOT_CMD_FLASHING.
+ *
+ * @unlocked: set to the state on success
+ * @response: fastboot response buffer, filled on failure
+ * Return: 0 on success, -1 otherwise
+ */
+int fastboot_flashing_is_unlocked(bool *unlocked, char *response);
+
 /**
  * Reboot reasons
  */

-- 
2.53.0

