Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF6606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0XoM62EG;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CBKp4leS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DUdIjvcw
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA76240AAA;
	Fri, 30 Oct 2026 05:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hcik-iBvTksd; Fri, 30 Oct 2026 05:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C05C740A9F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793339860;
	b=DpM5OXonfzqUF+HIxwUxaNle5PadYMczE2Lmbhh5MkfbISEbXAt0J69JKkprMdL5pEfE
	 3Yi8rWsV4hL3pyLBkO/Ga5uFPH/CRjLvFK249C9XIt9qIZPP/Ov/vpgr/YBY3zgzct0c7
	 3boQUjjpM0SPh9k5mJs4xU3pmE3f+9awt4dR5EIgoU2+Kw2jhSSxrL8wd8ytpg6MKxeq4
	 jZ0NFCCC3RJglywm1GH6uAiI/CkI7m8PR43B8TsPmaDYI+rBkQ99Q8Z0Ngs4eEeaJaeZ8
	 g8pncdl0EMNQr+htZhKBA1OQgeUCjZYlRMUFAG108Pc1ZOxOYcwJYbn9tQnM8R6aB0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793339860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5spe4cu6ZSjJ50Z43KYts1C8vi/CFa+N3xvwqCqzWgg=;
	b=i3pgXV6iV/p/nYiOZ+BJCyjnPQ7pS6esC63SOQQsDPtxvmCi7B3AZ67BOM24hL+4nRUk
	 S7Kqs3In+X43AX9aGARxZpr3s5iqtXSZmbqZVZCuOQBqRUUSQT5kxueaXZNIJAQrfS89R
	 DbPRpkS/tASWAk5408MVFHGHgudUrIXJW6rkwzxrr6amFEY+85sEYD9mMIPsR4BDcpt1p
	 fBvUhYTOe7e1nOu3nRPgnryOA0T1lZw9mkkieGUDVQ+ECPdjK4wT4cO7+OMQenHu5akUl
	 def85Il7Jihfoi0RiD5khBaQuvRZQeYgg6p3MnkoKeUphVS9TJ++CRuCF/cPzkmL0LQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CBKp4leS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DUdIjvcw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793339860;
	bh=5spe4cu6ZSjJ50Z43KYts1C8vi/CFa+N3xvwqCqzWgg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0XoM62EGdm0F9E4QXDEGC0b3iPPTFaSj4Q2KqEPE6KGvQkMhlMM0PtgMUXILYQosu
	 HsiCk0bzRIaqdNiby0yrhlThXnhp2MyADb0reEDKh9bw+/mmtyUK6lS0QsWA68yGT2
	 fUovGA3Oh6e22X+TjSqLgH9FgHsIpmfvloNBOADNhQOfJjhU8xVlC1awcAwuG6iut4
	 iOTbnl4D/O0YOwkh0QEn198G0G5QIM1inox6443aFuT7jx/ZN/YnKpexa38b8oC0hK
	 njlI/Yzc7kK3+khoHz9HUwuGg1SG11A8U9TQh2mW5NhIx3pZU0WNUpmp/wi4PyV1Pg
	 KBwukYgM+O8oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C05C740A9F;
	Fri, 30 Oct 2026 05:57:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A2A5E1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93D2940A9F
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oyq_AjlqJvXz for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 05:57:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C0E2640A9C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793339857;
 b=B98zZ1T4+nDN+imLyt21vybQAHlB/HSd0w+k7C8DhhNkVyODYAlHpO9fyDH7WoB6pam8
 A+IO1QIYXj/OMTteVhHpn11BoEFkOPROruwfUdhOc7c8zX/gYwWjWHEH1dNUWa4yMW4Al
 vk1EuYw2ac0zJZMQeoUzbiE4eHvnPWZOa2B8g4GPTHnLKw1v7cg+u8YHBAKvVd8KVOcxA
 4KHMzqNoFNQx0NObdlI11mrYJRQtooNnB9BJPsOASCTzTNkzxh4RXuIuvFrhnlvgJW9ce
 8D0jR/AVMCygIVT7lWb4VymJEDEggBsdc+2RBfV+n0cv61aT+k35EXEMHj4enhg8X1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793339857;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=5spe4cu6ZSjJ50Z43KYts1C8vi/CFa+N3xvwqCqzWgg=;
 b=oImrIfYqnPSsXZN2oh3o4zUKzPKGZ3ghtv87XRVdk+pksIlh+9QahXrEp0Mbx6TtR2BT
 WMp1efuEEPUZqFytPMf8Cp7vR3IGAga7LGc+cyyCbF3hKbv5p7fPBqFqx3yb0N2A9GArA
 MX/DhrU1vkF7t5c26vBCIFTBLn3OgmIcGDgRm01Bvt+zuW39DvZvApO67/j4KEczdbFkq
 mpd293FmXgDKf7tgvYHlxVmcERkTwVCu8dbGGAOtnJHMskIWCyrQIz7I5aQgU+tciITNm
 2qXG0JLCU9zcmIySEPS7PUEmrd0CQHue8EKKIfEUnGOyjMNVZsWNhB7D1/aXG4DGUBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CBKp4leS; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DUdIjvcw; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CBKp4leS; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DUdIjvcw
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0E2640A9C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:57:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U5FC8M3312644
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5spe4cu6ZSjJ50Z43KYts1C8vi/CFa+N3xvwqCqzWgg=; b=CBKp4leSU5TGeg9A
 ve3dHFqPAY5ZLv+QPh/1lZFh4eAn0F6C2T3MXsDmsX+uVImvV69bFs86vFe292VT
 ZaV8dWk5Sl4tXa1InFcHBtjTm7ayJBKb2WInk6CZLIhwU43A2laP/6z77HmAhK1a
 0kU+xLMn9Pe7fbmuovRvytNr5R3k+j7nFibSM6IWl2QwqgeFLAXDtB/M39uwo1I/
 uPjuwL4qTJ0aY5DR8frn725t2CRJv0HzSbUJCKHqpZ2dPTyw9GCetDAOZSTwn744
 MQ53SQ4kCibh/Dcd5wOimkdtdfrQjSquORdyUluj1D0pvez9bVMO1na/67tR6jjJ
 fxk5rw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6rhg87-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:57:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso872147eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793339856; x=1793944656;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5spe4cu6ZSjJ50Z43KYts1C8vi/CFa+N3xvwqCqzWgg=;
 b=DUdIjvcwr9H6+zV/mfYcfrHCJOX1Z5HayJ92wMAuMUUzS3vH4TpiORi66gJ14tTbHX
 0zKsnaX+8n5t5V2EcnjJwS/Q+FES8w4jRukhmZL7k63ZNLYY+FB9NVM3XHLqv+EJZZ4Q
 IztDRmL/X+88cCyD3TUD/VmrbaUJJOpsUuOXD/I/FMOibYZrN/iYDB5XBbJ6Y1jV6M59
 ZGi5x/rehAhV3UrWV8wHy4zrgQzcKreLMD+8HuSn3XEWiDP+R6Y4UXVz43q28thwJKI8
 h2K8SUEnKBbBd6By5bXHFL8hYXkZkPYqL5dfdA6QuCpd/NX8PguTMErxL9H27LwbbjBD
 21xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793339856; x=1793944656;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5spe4cu6ZSjJ50Z43KYts1C8vi/CFa+N3xvwqCqzWgg=;
 b=CgKC3gasn/QbqkqhqiFmb4/SkFlIxyFafktepvwsrK27g9ByJLqDeMd8YxsE7v9GmC
 ut3anPWHCmATkyai1v5JWOAemng4sgH9LIPBdiRKhyvlFLAZSqEa2qwx3Zj/JPSZZQr6
 ItMWaPDf8i4Z0/b9PRpiwikWIY9c/alz4ogtEGnHd6cV68T1tnbIqYvaI9MqRqv+NOp5
 ccmzmNepJIpztt2rHuIJC9aiKFDalWH3O7yhX+rVKjXa5chzcQPmCWmIKQc0HljxYF2P
 W0e8KXkm5/VQ7jqrCKzt0eq1GiJ23e92tVlWjbJGLrdjJeyuGIuRLyXg/NyMSfsoVpjT
 8hCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIfwp/T/DC4tR6ghPUystVMl4cDH6lpDZXLc4CVXvA/ExT8JNB/nk4HorwbQrWS0clQzPVaKI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLHX8jilcDSRQmFTJeTVEwoAzDEuK+AvKjeu9Kb2JV56Q1gdxww
 E4qMjbQcUsjNQYEJDcQ/Jh0ri/oxsPCjAjGg2le/GVSADUvgY0MGsqsb8Q0rO0ow4pqydFZAnqK
 bt14XY/0C04IZkssGKYFOqsKzvDZ5RcaKJ91RaEG+pADY7s4ykj+jdHwvGjJEIKSD2ySzQW8=
X-Gm-Gg: AYBFou3VfOpm7QxDev9VgJXxECe37K6xxDINUkPkJJFAHnki6bFVlikVtnTErntjDbq
 dlXH4VrSw04nur/cpW78kCnTkctzGONpxVe1X8Pa8+CQbox204scekhq00sSgEHm2oLYcckxf2N
 8sJ410JHVJliBJgZjbjI2VHuxlXPDUw4vZZP3g62yTdez9/nhRoZ0ryG/Qyy4qClk/EyRSeUMmq
 m4TxoDnc9h89aSxj+mpt73PYa5x9pFjdH9lq9VogGAvAjcisbblhdvoBPz/TNhRkIfvIpFj1c9M
 aUC98B4Qv24wZ2wcB61cmwf+P0/LyUHhgj+X/RTCmf/p9NFNkQjhR/ITk+NgZ7zcUG5iVgNUIiY
 8dGPEZuiMLcf4X7B3FrYMvugc5FEzmVRpHW0oAAnTBVmodpuUYqaaYQyzBoBYs6OuwYoivbsaNs
 hZ0Q==
X-Received: by 2002:a05:7022:7e0c:b0:147:a685:9125 with SMTP id
 a92af1059eb24-1ac574556abmr1898275c88.2.1793339855829; 
 Thu, 29 Oct 2026 22:57:35 -0700 (PDT)
X-Received: by 2002:a05:7022:7e0c:b0:147:a685:9125 with SMTP id
 a92af1059eb24-1ac574556abmr1898245c88.2.1793339855302; 
 Thu, 29 Oct 2026 22:57:35 -0700 (PDT)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1a13652csm4227055c88.17.2026.10.29.22.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 22:57:35 -0700 (PDT)
Message-ID: <e8d94885-0c99-409e-b5db-5f501cab22f1@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:27:28 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cdt: enable CDT for Shikra SPL
To: Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, kr.sowmiya@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261023084019.3722376-1-abhilash.v@oss.qualcomm.com>
 <20261023084019.3722376-2-abhilash.v@oss.qualcomm.com>
 <20261023140447.GG3596691@bill-the-cat>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <20261023140447.GG3596691@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cgB6heoVqsXVVpo-yDTs1sDg0J50chmE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAyMyBTYWx0ZWRfX2/H3l2v0JQ0c
 MP281Nc54Ks/tLBMSGTsRoeSbFdttPoKbg7QKUyjG9PgwCcemEpgxNIbAllLfnM09j7weAxhf3L
 TTHdH3vr6sTPREjdOeOaqQuJjPUWC/Q=
X-Authority-Analysis: v=2.4 cv=PIqaavqC c=1 sm=1 tr=0 ts=6ae431d0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5QL518lX8pF_l6tOZ4wA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAyMyBTYWx0ZWRfX7XT6Ecq/Mypq
 5gGQuZ41QJZCukZBsFqdtNofNoue7wFdDmaUO9Lw8GgKnRnSHJOccATT4ebqilT2cigAH9AulIb
 EjlsworpuzEHy6SASstOjx8ad6AV68lJz5o4OiOYG64sLRtChXEX5v/xxfYSrVlSAwDE9VD6cxv
 iWdkAgulaaSIYLiwBIh3QNOd5JTpaRttTsVZZOaiHNXScRcFKnyerJXYWjfDgwzxSoWOzRpwdSO
 qZm/VKIOiSSBy3pTxkUlWB9qnvPHOMxF2J6IAd4rTCTM3UrkQLUJLGEaow6aKbwL0SX8ortg98I
 3eo1dTmLCjZZqzhpE4R6RgOkb08gYDVdQv/yOiMsgfqnQdjG79QCHAa3TpZ3Dm0G5bbuOzGBziE
 NxA1XD2HpVyTVF5XV2C981OR0CkhFdTZftPAhCLkLLrNeCGMhHVL9/0avgn45W3pzEmnrj2D9fK
 mbpLeDi8X95C/EP5tpQ==
X-Proofpoint-GUID: cgB6heoVqsXVVpo-yDTs1sDg0J50chmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300023
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,KHOP_DYNAMIC,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/23/2026 7:34 PM, Tom Rini wrote:

> On Fri, Oct 23, 2026 at 01:40:18AM -0700, Abhilash V wrote:
>> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>>
>> Add support for loading the Config/Chip Data Table (CDT) from eMMC
>> during the Shikra SPL boot flow and registering it with QCLIB via
>> the interface table.
>>
>> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>> Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
> [snip]
>> +int qcom_spl_cdt_load(void)
>> +{
>> +	return -ENOSYS;
>> +}
> This is only called when CONFIG_QCOM_SPL_CDT_SUPPORTED so we don't need
> a dummy.
Addressed this comment in v3: 
https://lore.kernel.org/u-boot/20261029062431.3117727-1-abhilash.v@oss.qualcomm.com/ 


Regards,
Abhilash V
