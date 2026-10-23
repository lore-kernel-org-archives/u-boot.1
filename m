Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7300606A320
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O0l8r4Aj;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dxE8/9vp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYnwbs/a
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABDF9608FC;
	Fri, 23 Oct 2026 17:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i4S_PMhnGwG9; Fri, 23 Oct 2026 17:44:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0F2360652
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792777496;
	b=mcqn8piQVxyPPh8gwnfIrnCJrBaxaFiH3PcSk+1kDmvdOKSDNghLq3xb5dH36nO/KzQl
	 qcichhhBQ74041u5pEw3oF7lZFb/m0CEKaIdA0hhQF3wt2cDa14EiE7PNIiDARkwtCUpw
	 g5e7E5Pb9L0IOj3dVQpgFLrBrpWSrZXyb2AH3sVTSdgWpePdsF7d2KKG21z8rVWOGLxhS
	 Z6NytVkUHTN9IFvqcb5Z1uk3nwt7UxdMlHkud+RO/gza/yCdJ+EC+xIXjlNrQ39Yd8QsP
	 OivXNTm08AN//3uFZlJZPim9kH7cLpRSdVPo6JQbOd4uWoeYXVEVP9NZylap+pfwo1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792777496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PxgWKeCBcnA2fBV8cE1cbf9MrQX1x9S0/9NjxQKUMOY=;
	b=ELbrSOZ39VUKn65k5p5yqc+qvx5az1IoIdn7W6mHLZiOmeJvrW8PpBsXN57Y3PTKvejh
	 C4PVTBunqdiGGAjud1+O9LzhTgAsS/qHJAHCVYJqaSklr/uIjYFVJPs3ao4a89tdbUNcN
	 tk+pCDqJU4ZLGLkrnrfzY3GCB1+OS2AYHWPSgG/3oUR/wNKCbT0WxN9nQxkIKZLFt8DYu
	 5FnJEreddXEOygVMBKXvVLgWTrxvy7VQv45iebmFO5+utFdtz7pwb9/Rn7/3SaU4mYULJ
	 yj2F5mJVBZQLN3pd1eFimVWYG4z1ZMqOM1OvCYWT+8jzl3V/BOZZaLDNrtYvscbeU1Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="dxE8/9vp";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="RYnwbs/a";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792777496;
	bh=PxgWKeCBcnA2fBV8cE1cbf9MrQX1x9S0/9NjxQKUMOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O0l8r4AjXBU8kGdM6dYcdwull3wYq4ZuLf7f+5Go6dpp14OoEaXg0KBfYVZjYIcOw
	 4YPufhzVlTR92iUVTfmLXXTVB5TyfmUpSfECzTK1s7vZrJkAqHHL0ZIDdPCkIndxtc
	 2ofttbUVJM0naTPS/aYeUqClWHt9eD8EXmk8cbihPJVEDUJ1r2vxjBUbXAH0RkfU8N
	 1R6yvFvXIxQWbb4mnJ6uX9WJmZ85WcNCDdYeYU+ZeDEx1nLeFLFaZ3KO8YzkVCIT+X
	 KWdj8OMPJGvY/F7Lt81Mq6viJtwhdaIkWLu774vIXLGBeV534PEZSy4xP8GuoLqxQy
	 waENLUsw6j5dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0F2360652;
	Fri, 23 Oct 2026 17:44:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 212F012C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12D7F60626
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rWn9OWeqg_Bj for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:44:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BD2C60618
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792777490;
 b=qBxplfeNKRo23tIcsmxwUux6CZ2bbya3VNo9PVmF+OFnKZmw36z2GLF2N1tOQwQmTwsc
 KUbIXUMYCMTLvrNNcrJt8OfwxQwwfPgnLFaMpSOyHj1c11ICHzS25L2dyuqzlq4cwpqOC
 l/LLhi662CFnjeDol9YSaMn8f6kqF9GSX2nK5wLil0ILJz5UaoixPUH170leT47qaRgCS
 oCViAn7IWfzd4bhHjkwNRDlFKyJVO3O1/sZPN0biAyFrCwln+eW4PVVihzJmG3GTx/QCw
 dT1uN/DB1B4196c5adOsZT2GxVlPfOQ38yAWT9NvJcfIjJNWRy0xCBsnFkhWDea80ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792777490;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=PxgWKeCBcnA2fBV8cE1cbf9MrQX1x9S0/9NjxQKUMOY=;
 b=U/WwcZKA1nTgFvSVhTube9wJKVuAjsHCpsKQtWUgkrj3Q+DCQjRhXsvbes4RKb2MoDu9
 d+O/urB7zt78pidEJKx9yzzNvtFwhZBe3/iJTV06T0sic4fsXILUvS4aO5Ek6U0hWY2W4
 xKec0C32bxh0sYOcx86r7geBYHT0RjDIgosSjcopxtBthoqsb7cud/qDk05Y7gEJ8RNGL
 OsYF8yS42zjP2rYhDQRTbbmVVYrY1Ty2FGHx3TY46Slp4V6v8xtAJRVIE2SV4kHrSmijo
 WVeqhgHtOErtVm+SMSVc8eA6o8fdAZ3yVKvNRfTqcqYrD7+njtdjWx/I2bbrNykPbNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="dxE8/9vp"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="RYnwbs/a"; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dxE8/9vp; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=RYnwbs/a
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5BD2C60618
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:49 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NG31oT3733966
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PxgWKeCBcnA2fBV8cE1cbf9MrQX1x9S0/9NjxQKUMOY=; b=dxE8/9vpCGWzXrVC
 /49d74ScHIU7OmfwU68E40S6dsmBhtnM5FZLfpRdK4Gg3WxEsz3VrAl7jgYJMORE
 KvqqSkz4dDK2gW/1u4qSNuPX8X3MfpY7bTx2wpdsQOzXqBDjYitWO3x5a+5tg3G7
 /u1hr7VOdSlEOl6/1qnVDRpTSvxb1qcRKqnCiPAdqq3r9F5qMfT0jiy/UovUh9tT
 P3YnIxa0UZhSwwMVbrhlKO0yb2ql9xe8qK3IJN3CVz6rvnNhIMdRSouyHgwLLGIZ
 ordrWhhaWJbTi0A27g9yEXb8oP3N28vTeaW9Vx6CmaX7f7dI0E24uI5mvp9awuVa
 xI/bUA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgarugchx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:44:48 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-8b09ee23de2so19024157b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792777488; x=1793382288;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PxgWKeCBcnA2fBV8cE1cbf9MrQX1x9S0/9NjxQKUMOY=;
 b=RYnwbs/al6i0iKlwSoUgC98D2iktalmi3ON3+3PtcwLVPUSvwuk1CIWFoxY276ulmP
 3cdfiqADdY4SiaW906xSqLPJq3T/RJhsjB1feNM39Ze1pIWC8YM7zJ0QcXQtQrgptKxX
 OskZxle8cYUJsGp7p1Hpzaki/WB8l0Qi/dJqRW9yi9uWNYppsC08w3cqxUotzLqbEQZc
 ru3vxdajbrANFw8Ffbw/7F+xgd4VfU5VYiB1R8NlYsT04VPdlA0CklkiNOhkozGHqyni
 RBN5KvAzwcn48SZA0sdlZXAATeDaUzxxSr5AZxXInUlLA2l1xQNgS6p/g6uv7vngFSZM
 Leew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777488; x=1793382288;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PxgWKeCBcnA2fBV8cE1cbf9MrQX1x9S0/9NjxQKUMOY=;
 b=QiX+1Q6nQXiXt6MDIPzEtyCf4V9GCpVawvRkf+fiigwVVn7TO0LiHKISNwiDI8OhVo
 nsZEdsAhKIckkoe6WSc6lQuFJrjfCrfxe3wppVtqjlqZXQ0HEddXxRuaaZXoX2MDpkUA
 R/Oz3V0gDRbyuiUn8aNrop6z8T4zDAL59FZGErsoQi6/N/k9OudUUMvvt3H1DmJBq8KP
 gfwOHStD5d6TRx4ke2NYWG5TAQPVdqpoR8TJ7vbGcrN+d6gEJQpT8GsuaU4roQYYcByG
 3HOJUMwkyhIj7H3mq3IK3GbKFI6SrAuOnWFXB3zeHq6QbqmD5CYj1cCOnkwj+FmcjfwM
 5R/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1PRnmjLWiL/DbSLYcWNCus6/3zpWWGCD+T6MIFjoA1qQGsTqB7+v8F5BcIFT0czrDAGPOE+g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIlQDzPE3m4qCzuK72NuZfgN7xExN2guwZPbtoA3FS8RmVFGpaz
 BD4tRtrNwLP/I12oJVyH/+ZfFw2ikKmcJ2iL8U5+VR4Io+blYQK6Hs9aOPa5xsQSH+4f0QPIcLx
 58DeolDAY7qrjtFSbgcd0ib5eTUvxqfBuBRTuw52Brf2jx/X2In1ZuwP37uYEOZ1Mpc6cTSE=
X-Gm-Gg: AYBFou2VPrBv1YxqtEgMdO8RyUoGMBsuL0ld+HJ2qt/YJ7bMrapRgi/csswf77dZMU3
 dQvfudh8RicHN0wRMFr2xw2bcUt1SexuwQbIauCrR+EsIMbPLwYiO1tQziiR6d9DtLUqpDqDyt3
 xRV3tJQfyrp5lhcyU37AUz/+FU/JtSevtCLum7Z/QGAxZ/C38nbEm8dCJEFhpgx+Ip0K0Opb45Z
 wYvrVPjqyswE9vjzdJwUrZAUky/yVdNEM/+PKB/dPiT4GjisSw3pAbA+RbAKrC7XV3CF9oZIS1P
 DDrlcsv7fDDbYJgh4EWmDeA8KelHLRbxBoM9Ul5C1oeZ/cMAA9x6NcoEdGL4k9XzwSswxC2ML+q
 wMikX+OeZdD9108/pew3b/xF7pEWZ4m6A0USNaNCoqBRmoukuqNM5QDo+P9ho
X-Received: by 2002:a05:690c:f89:b0:8b0:76e5:ed0c with SMTP id
 00721157ae682-8b157d31d74mr21001387b3.39.1792777487454; 
 Fri, 23 Oct 2026 10:44:47 -0700 (PDT)
X-Received: by 2002:a05:690c:f89:b0:8b0:76e5:ed0c with SMTP id
 00721157ae682-8b157d31d74mr21001197b3.39.1792777486832; 
 Fri, 23 Oct 2026 10:44:46 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b163dbf92esm2823357b3.32.2026.10.23.10.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:44:46 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v3] clk: qcom: sa8775p: Add QUPv3 wrapper 3 SPI clock
 support
Date: Fri, 23 Oct 2026 13:44:40 -0400
Message-ID: <20261023174443.1552137-2-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016-b4-sa8775p-qup3-spi-clk-v3-1-7b9867dbf65c@oss.qualcomm.com>
References: <20261016-b4-sa8775p-qup3-spi-clk-v3-1-7b9867dbf65c@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX36W1je1CSD27
 MqiqGRtwB5433iPF+NXVba1en6QDJrG3PAHf2y26hmZekWzIO28/XXKbRTZ37CCA5WRrUNs1Re3
 cC936GftfUnvjrdswsGEIHfcGAEagSo=
X-Proofpoint-GUID: Tlbs07pkdJyiSZ85nRrMz19gTgVllZ1H
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adb9d10 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VlT2PTjBbVJIlTuAYuwA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: Tlbs07pkdJyiSZ85nRrMz19gTgVllZ1H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX7voWdHHHLYcZ
 OTpN/7o4DUlagImW0AvNLAc7ViWVygnwsk9W/K56O7chOV7MXAWLIzeuN7gjxNfi4EKr20XGqzK
 0oIHjxDOel+A0R6TcEeJ9JbtYh2pbCZJtEnCFzKwNG/DX0ZNPFlDj6rtV38MWhfb9VngpwpTCco
 k5I8pE3rY/oiJDDVy19hgCNcA+FnAJbpZ8IENCKFPe1tIJe4kFGHVvIYW4yp6qQHxph3TO33oCQ
 t5hSGELLKWMm4jZJI7A+KXXICh667TbwzPfUNMewGNFXznGeaSZJyD+4R0TCbIqjWIs6w7QSDsN
 T8Paa81HF/tYFJCBa4HbgZTp6fB7iJNSTKsGe2ilLwKfIcsLF5reModZBc9eM1J41P5ULfYpUuF
 5yaQNAJolnKwUwKTi6XFST0Rq6ekb6Pp0nye4IXQcipPFLlAEbVokBO1zr16liNs89axSVZ+X9y
 VvbxJPTphTrbRKscgvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230069
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 16 Oct 2026 at 12:03, Vandhiadevan Karunamoorthy wrote:
[...]
> +	GATE_CLK(GCC_QUPV3_WRAP_3_S_AHB_CLK, 0x4b000, GCC_QUPV3_WRAP_3_S_AHB_ENA_BIT),

What turns on the wrapper's m-ahb/s-ahb? geni-se-qup has no probe, so
they never get enabled. Wouldn't doing it there cover every wrapper?

> +	case GCC_QUPV3_WRAP3_S0_CLK:
> +		qcom_gate_clk_en(priv, GCC_QUPV3_WRAP3_QSPI_CLK);
> +		qcom_gate_clk_en(priv, GCC_AGGRE_NOC_QUPV3_AXI_CLK);

Does an SE in SPI mode need the QSPI clock? And isn't this aggre NOC
clock aggre1_noc's?
