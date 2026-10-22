Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589FC606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k5/JsPe9;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WcTOl3Rl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZgTqD/Kb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3677781350;
	Thu, 22 Oct 2026 19:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPFT0brybGxj; Thu, 22 Oct 2026 19:05:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FC338129F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695902;
	b=Zc8zFz6oHGOvavTawZQxgnaBjIN7Z4sXFwVISeEIexEzkC/jHrQEvTj2JJAwvpG4mTIR
	 1kgzoChiMkyovaFLDvPmQO+dR/1xb+r5oOhZTZyo9y/XyoD250P0tGU0IinrxvAr7Za4/
	 CoVgz/B+lFcdJY8pkrO4ZuH8rlPMF9DKQMm8BEgub55nH+80OyQucpAHTvNQTfQOSjMqh
	 jyDwzO0WC3Jf1Xkvw46YItyaA1SDwdhdC+sDC/Mhi5K499y5XxS4kV4qJBvRbQVjwyeIP
	 RJP+1MoMTzjMSIS/ZuLAGrQsbzUj3/gzmbz4XIDUzgE+Y0pokm51E6X7CsrNbVa7Znw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695902;
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
	bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
	b=owvQqAZPhIb8bRSAXpkZb1L7VC1u4q1l4X+aypiyYAdNmE+D2VMO6ENE2vUblb/6wo8R
	 /ExWnWhmY5MfBPWO0g/vfc7aMsIjxZKPJm4jubeteb4mwfFzJwJj3prlu1DerQiwCV6EG
	 guKCg68n1xTmjl5PPl/t+kTbfzipklsoeMp3xSd/6RThQ3CJQCLZzSf9NJSkTqwO6nRGY
	 1R1FVR7W1r9rIIJdHHmQ3USc2SX/k/MdUvR981lEI4m67J1BB2PFsB+HUq3iofa7qmUNo
	 ZnPDpan5joReh6wy4BOidMJ1Dx0BdJhJX2i/+5QdNPJDLkzJhNvuyfHeKL3OW7nuLbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695902;
	bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k5/JsPe9PwmTFIGl5ecj8Br6IE3xtcOVF3ZgAYX1KYrbSJLXe5H9I9+5gk3/I7dw5
	 do9SbrfwH07Izhs6JDOUfN1HFbH6etE+AFnG6+uvRnWE1YZbW3tcNAjIpVYlDUGROh
	 denc2nShEOdHsjcnlSqwfSZtTwtlHBdtSG0e1ohrGype1Qh7hRzktb25aNrbUYpewE
	 Y5VsB39smlmMsd4IcBaOF81MXAQYCwqD3tBJHdWfVLR7n3BKiJozTGMh1IY1T79htq
	 IhLrNWZZrf7bpkIhKlnFs+wUiOEJDcOpDtChvv1kpuwMw2F/otebkdM1SLXflEJ7vO
	 y23/HG0UAwOMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FC338129F;
	Thu, 22 Oct 2026 19:05:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FFCD3A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 111484099A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vxQidZNOLfBU for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 085594064E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695897;
 b=GQO0xWNXjTp7846JYrY3IxDQHwBuUyqc5oyNQEVm/lZ5QhtckAyV2n0QnlI/lzPNYhdQ
 Rky2ywPa6RsvcLmGynYO7U5tZmoTrGe2sZqHCzPo+jzyDM1b802QZhCuBHevmToneEZqE
 RcYUdh9nla+xkwctbZDvadm2EKwfOZuw4IWgsT/GIGwwidy+Pg02050eZRmrs2Oq+QRH0
 2Dk9OYdPW5w5SmUAsBs95nls+0SkpOdyQHb9vtCp8XD2jW3UimSpsta6/QxaZGbVG0Niz
 efs0htUPdnxTY6TFv9uOPqLxsMzza6hoWJpXfEXKPsgPgg0BvUR3+wfrD5sQ/MlkuRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695897;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
 b=KrI1YsafY2QgHLU7hsI6N0+sBpZjNRjxa5fJpoeGckpOanPVWSGkrxgue3HD4GDNVf33
 cRHK1lK7oimGxTBP+12bmre+fzd91jHEQpCFL3Suy8lwG6nJRq7+Aygb7sn/6moo8txRQ
 RCCSDeSrREIsa1pVyAiLQ+tAsttuuVMu280rCkQHXEVg12d9PyHgQvtMgZy9rOH6Rx148
 kghztM4YS6h/YijXzjpEk5z5PHliIR3qsUuZFLPhVJDbAnxJac6S00xjpHF8BVQA4gphj
 nsp2LrnHb8UC6BtHF0k8ifR2nGbPEhWx0OTqMweEnld9TBXHWncPlbGf/QePi9aCpLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=WcTOl3Rl; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="ZgTqD/Kb"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WcTOl3Rl; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZgTqD/Kb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 085594064E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHBeT3741656
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=; b=WcTOl3RlyevXdKci
 w7CVqy57qETi2//Yo5T+osB5s3dHXR43XU1uI0rrFjt0TUMKV4l3BLxLgrhUOAWX
 Cc+067wa9iypIwo6zsBd+BPQORcxUQa+aHyXvaUbW5jiLTa1BHRNWQ26w+VriKSM
 OCg1d7hkEbuq+zDxzKat6UU3pAeW/IdaS56CXz2ul9YcEwsSUiihdAwLGLh+/5P4
 s5BbINZ7KCCyc106pTn4uhrzx2OzEoVX8o9Jvsg4lN0EsF4m6AKD15hcnUBI0C6L
 mZMw+LlEolmbWNmL1XBbmPjC0xT2PdLXFWiFNpncAa8fcYYnjHEo+KRWOdSu74RI
 aAQfzg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms05j7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f32050e72so31123685a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792695895; x=1793300695;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
 b=ZgTqD/KbTYfRubOzzFZUexPV03Wb/7S07zQuX27CC4KOyusipiYCVrGuD0cn1St2DZ
 yjHVXcSws3AW4sLugGCWtGBZeeRN6Ll+VSLm68OfnKLYtTST4eSx7vt7MKSMLQlyHCAi
 L2uk1S2Vvnwf9hL01RCNt47pRYbJC0Ufz8sLS1JqC/jM5DASIuo8enQ07HKVT3tae4pL
 AOxd9GRsBXegqRH9P5jh+z2ZdKLevq1i3Y9oxMFsUKpWCAfsJY3L86pa4XwWyB9+rqnP
 r+qSKkwVwWv1KUQYjQUZF1uQx9gTpEehV564ekcrID80ZTpNsao89g/1ek1AYnDUCAGp
 CNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695895; x=1793300695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vpcHPqYRwxYV6JxW00pQGV4iZLyyRalww5ts4GEgYkM=;
 b=v4j1QjXyCrGa/M+tAZ2qHJHBqbrZVFGiWAWQThbDXBHcjnw6YfyvhQhpiuwI4fCwXU
 nnn/awFecOc2fnVzdAvHVmmPQkSZI5cq6miauQ4T7MkN/EomZp931Gih4XMOxsLhSEUP
 93dOxaLaaqTFgAXL9dit51xA2lxDbiSKAZdpynCsyS6eeH4RjqsJ3zPKLlQGqhRBMW5E
 PRNmVpJUjVNscc8J+D6TFBrqd0KF+MWZcGvGfAYrUFEgs4NsiZkF7b3/+sm1Qg1vJIXh
 N6fbKVzsqjRVC7yHit2Jrd0ntDh64aseDUTUGM7tIyVVnvYTgkgLQ+E0oS7re5euyfbe
 avig==
X-Forwarded-Encrypted: i=1;
 AKwUvByCNZwM9XzZOAB9i7FNbFD3/LI4U6/hOHxF3LKebEkq+hDXC09TaiGXb7yhvo+I7zGaEXlO/QU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIlZ/wgzZvSMiRN7UN2yD20X8iVTUyLqnhP5kfbTTFQIaedPU1B
 Tw3YJMzSJxB1kqUDEE6Dudluzb93tZA106cuvD0bAe2zJp0VlNmHJGIOZLBih4OruaNYYOQ43sa
 f2v+3LyH2652nqwKSTegbCnklQEZ6VsnYvEE7Y6dalNMMdBQt4J56rFCPlJ9Bu8xuFjvTqBc=
X-Gm-Gg: AYBFou1pIhOm6PMd5iH3b44q1pmKis9/EZmcszDzAiPjEpc7oss8C2HJR6zbPx/rtX8
 WQj3ER46DyrKD+/SL6FunbJy9SnrK5qeo4B7nQRml5S7M91P5pd8kWE9F2viJlq2dUi9FgFlGlk
 +Dy0HBSPiPszSOCgtuQios2zlQuDBd9yAi/U9+ghKrH4862BWMzH/CwLPGi2Ham63l7hOL+VIQ/
 rz4E8ZLmnVirCm8yBeKea5ulFqgxQ6+UWNt95V0h7hrb45gV6C1BLgwg9/Gn0JoJKwfJIrrqMRC
 h9gNYHjormyJbxbAxqt8WmxBW0yfifSjqk4ICUjxRc6m9ZDsgMwfplPT3w+02Pm9yf4jLISIONx
 Ot+sFaZWK0BA+SXAbPdLxKKqpS2hFSP8sHGEqyWA4HBsV
X-Received: by 2002:a05:620a:2a09:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f6f9b7400mr66512385a.59.1792695894626; 
 Thu, 22 Oct 2026 12:04:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:93e:942f:b8a6 with SMTP id
 af79cd13be357-93f6f9b7400mr66504585a.59.1792695894021; 
 Thu, 22 Oct 2026 12:04:54 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c8295fsm18914666b.36.2026.10.22.12.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:04:53 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 21:04:44 +0200
Subject: [PATCH v4 3/5] avb: verify the boot images in the buffers they are
 booted from
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-avb_lock_unlock_b4-v4-3-f4926ca925e7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfXzVKMdI0ScMx6
 9OfbnyrpE+Gc8vyWl6RUgKRl0wYD/OKayI7ADfpb1dAVFeumV8+CJq6hSYDsf7u1wAiZRB7dBOD
 UyCeKnGlMEZ2u8bOqULst4HrCMUS/PWUkCTjtgAGjM17gD5WqAibnl7b2/XE0KmwqG1E4fMKEbl
 9FV8ITPVb0xOUBMaArcTlAJE4W+z2hYoaKet8oTobtrsazm4AFrkY96IP5JJw3A8odPj7eoZv+I
 Py7y8WCJ3ADkrZ5zD5izO0gJB7lD22W/W4C1ojLP8Nw9umfv5X2Do4arOGSXpim3qfPNYIoe+zX
 36/ZknGfkbjLMGh9+yJOdOHXPEd5QBryxOBY3C2ATq7UuUY9dEXOeS0mfM8nktqcxIuZrH7HXh/
 OzndHmSNCIF0aay9gA88L5leiw1B8WsmjalpkAWgMtWe8pHzAmVmPcxdkw1GyBejfCwagd+dNv+
 w8BdiEY0tL49YTNVTSA==
X-Proofpoint-GUID: LyV3qXW8zd_17p954Cu67Wrj9MMOiwkL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NiBTYWx0ZWRfX0FqjcFkFYnvb
 32bmTkbPMk+7ISRsYtCxrDe4gy12Jd0eC/7zXsh+yVx2VgOrcBsW3jZ4rYzPEO7N8DVtWSEQDq4
 pH2nVSRc9LdiP/GMLfdnq4P21+ZkVW8=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada5e57 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=qJaU2Z4SIW9asTuPRKsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: LyV3qXW8zd_17p954Cu67Wrj9MMOiwkL
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

bootmeth_android let libavb read boot and vendor_boot into its own buffers,
hash them and free them, and then read both partitions again to boot them.
The bytes that were verified and the bytes that were booted were therefore
two separate reads of the storage device, which an attacker able to
interpose the device can tell apart (reported on the list as a TOCTOU
issue). It also read every image twice.

Load boot and vendor_boot first and hand the buffers to libavb through
AvbOps.get_preloaded_partition(), so the hashes are computed over the
memory that bootm consumes afterwards. If a hash descriptor covers more
bytes than the boot image header announced, the tail is read into the same
buffer, bounded by the partition size; a descriptor larger than the buffer
fails verification.

boot is always loaded before verification runs and vendor_boot exists from
boot image header version 3 on, so the preloaded buffers are registered on
those facts rather than on the recorded addresses, which do not have a
defined value for a header version 2 image since the bootmeth private data
is not zeroed. Allocate it with calloc() for the same reason.

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Reported-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 boot/bootmeth_android.c | 73 +++++++++++++++++++++++++++++++++++++--------
 common/avb_verify.c     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/avb_verify.h    | 36 ++++++++++++++++++++++
 3 files changed, 175 insertions(+), 13 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index ae05c084883..6f7e232d2c3 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -48,6 +48,11 @@ struct android_priv {
 	u32 header_version;
 	u32 boot_img_size;
 	u32 vendor_boot_img_size;
+	/* Where boot and vendor_boot were loaded, and the partition sizes */
+	ulong boot_addr;
+	ulong boot_part_size;
+	ulong vendor_boot_addr;
+	ulong vendor_boot_part_size;
 };
 
 static int android_check(struct udevice *dev, struct bootflow_iter *iter)
@@ -235,7 +240,7 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("bcb read", ret);
 
-	priv = malloc(sizeof(struct android_priv));
+	priv = calloc(1, sizeof(struct android_priv));
 	if (!priv)
 		return log_msg_ret("buf", -ENOMEM);
 
@@ -353,7 +358,8 @@ static int android_read_file(struct udevice *dev, struct bootflow *bflow,
  * Return: 0 if OK, negative errno on failure.
  */
 static int read_slotted_partition(struct blk_desc *desc, const char *const name,
-				  const char slot[2], ulong image_size, ulong addr)
+				  const char slot[2], ulong image_size, ulong addr,
+				  ulong *part_size)
 {
 	struct disk_partition partition;
 	char partname[PART_NAME_LEN];
@@ -396,6 +402,9 @@ static int read_slotted_partition(struct blk_desc *desc, const char *const name,
 	if (n < num_blks)
 		return log_msg_ret("part read", -EIO);
 
+	if (part_size)
+		*part_size = (ulong)partition.size * desc->blksz;
+
 	return 0;
 }
 
@@ -440,6 +449,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	enum avb_boot_state boot_state;
 	char *extra_args;
 	char slot_suffix[3] = "";
+	char partname[PART_NAME_LEN];
 	bool unlocked = false;
 	int ret;
 
@@ -450,6 +460,33 @@ static int run_avb_verification(struct bootflow *bflow)
 	if (priv->slot)
 		sprintf(slot_suffix, "_%s", priv->slot);
 
+	/*
+	 * Hand libavb the buffers boot and vendor_boot were loaded into by
+	 * boot_android_normal(), so the bytes it hashes are the bytes that get
+	 * booted and the partitions are read only once. vendor_boot exists from
+	 * boot image header version 3 on.
+	 */
+	snprintf(partname, sizeof(partname), "boot%s", slot_suffix);
+	ret = avb_ops_add_preloaded(avb_ops, partname,
+				    map_sysmem(priv->boot_addr, 0),
+				    priv->boot_img_size, priv->boot_part_size);
+	if (ret) {
+		ret = log_msg_ret("avb preload boot", ret);
+		goto out;
+	}
+	if (priv->header_version >= 3) {
+		snprintf(partname, sizeof(partname), "vendor_boot%s",
+			 slot_suffix);
+		ret = avb_ops_add_preloaded(avb_ops, partname,
+					    map_sysmem(priv->vendor_boot_addr, 0),
+					    priv->vendor_boot_img_size,
+					    priv->vendor_boot_part_size);
+		if (ret) {
+			ret = log_msg_ret("avb preload vendor_boot", ret);
+			goto out;
+		}
+	}
+
 	ret = avb_ops->read_is_device_unlocked(avb_ops, &unlocked);
 	if (ret != AVB_IO_RESULT_OK) {
 		ret = log_msg_ret("avb lock", -EIO);
@@ -566,6 +603,26 @@ static int boot_android_normal(struct bootflow *bflow)
 	ulong loadaddr = env_get_hex("loadaddr", 0);
 	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
 
+	/*
+	 * Load the images first and verify them in place: libavb hashes these
+	 * buffers (see run_avb_verification()), so a storage device that
+	 * returns different data on a second read cannot slip past the check.
+	 */
+	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
+				     loadaddr, &priv->boot_part_size);
+	if (ret < 0)
+		return log_msg_ret("read boot", ret);
+	priv->boot_addr = loadaddr;
+
+	if (priv->header_version >= 3) {
+		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
+					     priv->vendor_boot_img_size, vloadaddr,
+					     &priv->vendor_boot_part_size);
+		if (ret < 0)
+			return log_msg_ret("read vendor_boot", ret);
+		priv->vendor_boot_addr = vloadaddr;
+	}
+
 	ret = run_avb_verification(bflow);
 	if (ret < 0)
 		return log_msg_ret("avb", ret);
@@ -575,18 +632,8 @@ static int boot_android_normal(struct bootflow *bflow)
 	if (ret < 0)
 		return log_msg_ret("read slot", ret);
 
-	ret = read_slotted_partition(desc, "boot", priv->slot, priv->boot_img_size,
-				     loadaddr);
-	if (ret < 0)
-		return log_msg_ret("read boot", ret);
-
-	if (priv->header_version >= 3) {
-		ret = read_slotted_partition(desc, "vendor_boot", priv->slot,
-					     priv->vendor_boot_img_size, vloadaddr);
-		if (ret < 0)
-			return log_msg_ret("read vendor_boot", ret);
+	if (priv->header_version >= 3)
 		set_avendor_bootimg_addr(vloadaddr);
-	}
 	set_abootimg_addr(loadaddr);
 
 	if (priv->slot)
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 7b60be4da7a..92f4f82df48 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -1103,6 +1103,84 @@ AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked)
 }
 #endif
 
+/**
+ * get_preloaded_partition() - hand libavb a partition the caller loaded
+ *
+ * Without this callback libavb reads every requested partition into its own
+ * buffer, hashes that copy and frees it, and the bootloader then reads the
+ * partition a second time to boot it: the verified bytes and the booted bytes
+ * are different reads of the storage device. Serving the caller's buffer makes
+ * libavb hash the memory that is booted afterwards.
+ *
+ * The boot image header may describe fewer bytes than the hash descriptor
+ * covers; the missing tail is then read into the same buffer, up to its
+ * capacity, before it is handed out.
+ */
+static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *partition,
+					   size_t num_bytes, u8 **out_pointer,
+					   size_t *out_num_bytes_preloaded)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p = NULL;
+	size_t num_read = 0;
+	AvbIOResult rc;
+	int i;
+
+	*out_pointer = NULL;
+	*out_num_bytes_preloaded = 0;
+
+	for (i = 0; i < ops_data->num_preloaded; i++) {
+		if (!strcmp(ops_data->preloaded[i].name, partition)) {
+			p = &ops_data->preloaded[i];
+			break;
+		}
+	}
+	if (!p)
+		return AVB_IO_RESULT_OK; /* not preloaded, libavb reads it */
+
+	if (num_bytes > p->max_size) {
+		printf("%s: %s: %zu bytes to verify, buffer holds %zu\n",
+		       __func__, partition, num_bytes, p->max_size);
+		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
+	}
+
+	if (num_bytes > p->size) {
+		rc = read_from_partition(ops, partition, p->size,
+					 num_bytes - p->size,
+					 (u8 *)p->addr + p->size, &num_read);
+		if (rc != AVB_IO_RESULT_OK)
+			return rc;
+		if (num_read != num_bytes - p->size)
+			return AVB_IO_RESULT_ERROR_IO;
+		p->size = num_bytes;
+	}
+
+	*out_pointer = p->addr;
+	*out_num_bytes_preloaded = num_bytes;
+
+	return AVB_IO_RESULT_OK;
+}
+
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size)
+{
+	struct AvbOpsData *ops_data = ops->user_data;
+	struct avb_preloaded *p;
+
+	if (ops_data->num_preloaded >= AVB_MAX_PRELOADED)
+		return -ENOSPC;
+	if (strlen(partition) >= sizeof(p->name) || size > max_size)
+		return -EINVAL;
+
+	p = &ops_data->preloaded[ops_data->num_preloaded++];
+	strcpy(p->name, partition);
+	p->addr = addr;
+	p->size = size;
+	p->max_size = max_size;
+
+	return 0;
+}
+
 /**
  * ============================================================================
  * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
@@ -1170,6 +1248,7 @@ AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
 	ops_data->ops.user_data = ops_data;
 
 	ops_data->ops.read_from_partition = read_from_partition;
+	ops_data->ops.get_preloaded_partition = get_preloaded_partition;
 	ops_data->ops.write_to_partition = write_to_partition;
 	ops_data->ops.validate_vbmeta_public_key = validate_vbmeta_public_key;
 	ops_data->ops.read_rollback_index = read_rollback_index;
diff --git a/include/avb_verify.h b/include/avb_verify.h
index e89bb229e02..2b5b24958ae 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -23,6 +23,26 @@ enum avb_boot_state {
 	AVB_RED,
 };
 
+#define AVB_MAX_PRELOADED	4
+
+/**
+ * struct avb_preloaded - a partition already loaded into memory by the caller
+ *
+ * libavb hashes the preloaded bytes instead of reading the partition again,
+ * so what gets verified is exactly what the bootloader goes on to boot.
+ *
+ * @name: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: start of the buffer holding the partition data
+ * @size: number of bytes loaded so far
+ * @max_size: capacity of the buffer (at most the partition size)
+ */
+struct avb_preloaded {
+	char name[32];
+	void *addr;
+	size_t size;
+	size_t max_size;
+};
+
 struct AvbOpsData {
 	struct AvbOps ops;
 	enum uclass_id uclass_id;
@@ -32,6 +52,8 @@ struct AvbOpsData {
 	struct udevice *tee;
 	u32 session;
 #endif
+	struct avb_preloaded preloaded[AVB_MAX_PRELOADED];
+	int num_preloaded;
 };
 
 struct avb_blk_part {
@@ -45,6 +67,20 @@ enum avb_io_type {
 };
 
 AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
+
+/**
+ * avb_ops_add_preloaded() - register a partition that is already in memory
+ *
+ * @ops: AvbOps from avb_ops_alloc()
+ * @partition: partition name including the slot suffix, e.g. "boot_a"
+ * @addr: buffer holding the first @size bytes of the partition
+ * @size: bytes loaded in @addr
+ * @max_size: capacity of @addr; a hash descriptor covering more than this
+ *	fails verification instead of overflowing the buffer
+ * Return: 0 on success, -ENOSPC when no slot is left, -EINVAL on a bad name
+ */
+int avb_ops_add_preloaded(AvbOps *ops, const char *partition, void *addr,
+			  size_t size, size_t max_size);
 #ifdef CONFIG_OPTEE_TA_AVB
 AvbIOResult avb_write_lock_state(AvbOps *ops, bool locked);
 #endif

-- 
2.53.0

