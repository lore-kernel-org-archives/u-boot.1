Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B4606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NTsWm3pq;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hoR77wC/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BEGXKAtX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13A3A60818;
	Wed, 21 Oct 2026 12:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAUH6lb2Q13P; Wed, 21 Oct 2026 12:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BA13B605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587260;
	b=klhwPup5FETJ5oJXAoxCgfNQAMXU8I3trwbC06aZ0ZH2Ekezi7EbPZfLTGu5QSQHFPv0
	 QV88Hfb2XhjoOM/jodRJvlK3e3iHlIILy9Z2OUnvFSM7SqZnKVvj3Yq1CYmKKOS7uS1Bk
	 5NLQWdaBM+tDC8gvck+in540pZQi+3Rw0+H7RDpDROB3myoH/riMwaAe5Ok73ePKv4qAx
	 MYcV0502OJfTSKkdHXvEYhJu5jvGfJBn19PhVHiGyulXyyRPJM/7mVPaxkcsNp99pJlHg
	 hiNhMMu2QvrQJGLnm+Em33gY28AmNeSIPvsZrpyim5Sm1uA4hZbaaBc4AM/yGSITamA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5QXBAZIk9B1WSPwgdYXiBPNgmVraFDu3I1/q+7ykt6Q=;
	b=W7uWKp2R7YhHkdrPXguV1na8FdkBbYZkELgTp5siUyQbumGB+2ctZbrZ/fd/xebTI2m5
	 3VoPA/LezMQsEN2k5/gWFXq5QTGDlXVsavceCljcWEz5dzmH1W7mScmxFDA2zkZC4hKvp
	 6S1R8WC0zFMMfBIo3uXX+N+2cwAAnomRWgdMS3siVqpMFjM2xCcs3agxV5A41RB47zdTc
	 AqA0iqt1MWTqsteJEBs7Kq4wlc3ivsh9R8xb9Ll5YqBZy11hTh3/wMi/mXAFddQCeMCqD
	 7x3JgVrW6KzHkwVlAsLwx7+rWZMhxTe838/dAj9fPBfuXstl1hLoDyEFfnoFlqn6pdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587260;
	bh=5QXBAZIk9B1WSPwgdYXiBPNgmVraFDu3I1/q+7ykt6Q=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NTsWm3pqd+Dt37K8SDCaturJWsYUm8sh8GKZIaGeDCzyHtLXMiuK9rLo/KFIF9oK7
	 xgznSTdbO6NrKXi/HbZDl1X2rlR9SuEBMK6LEELfk9FzN+2Q+kbUQstCUd/uY6QbDW
	 jT6t1YQ/UCs2KG0ADGC6cw37Y1LyXWzeorLwUBti8lS29F8hI2N6n/ixYaiXgABQFb
	 fIn60YAhrZbLH3B2tA3Wlw3qpZrcsnaJjepfcCDFBbFkN5u1TfeDj6264nOiZnleNd
	 ApGRzSrVHK/Nnt9V3Wa6gRYLfGge+O60TfHtEHMj56XAObuR1JoSKY7IhoDZxw4wi/
	 Nhc6EDmN5utXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA13B605F1;
	Wed, 21 Oct 2026 12:54:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 727F323A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6429380E0C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MSMOu7npRr9u for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:54:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1767C80C25
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587258;
 b=bnAmEXDES9bSEnNhnIMXRa/BztzjNpPUHC6zYoxg1mFlWhgoWal1u6N4KS/LRGviuQmU
 VTH7hza+yN5oLsKi9adDG+rWPYEaOC7+1UOzDhyMC1RoXHjxW63FKIOiY0Ofk6feqqyYU
 Ho3JAo97NRFousuyp3IzEhWOMiv0sMhLcye8ktNhNBrK8KQYU6Am7zSXBiPykGk+JSJDs
 nQji6G7/epbEO/uug+dOMt4Bwm14KX9g9lECvpgyz4/2k45YYaqMBLV/JKtkxY+WvKomu
 9j70DiqvvAPhuwVgWLSZb5zhXuaw2w80VHSrfB9ginF+BTTFlKVSYCvT4GkZyhsCVyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587258;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5QXBAZIk9B1WSPwgdYXiBPNgmVraFDu3I1/q+7ykt6Q=;
 b=dHIHv14ELkfG6MRqAYZ/Wb6A/gBZDvNeS1ICXC52JzOXrfypBZik6b3YSXFp2hlbiQyh
 AJRWFfI6DX5MGVzl3+RXB+N9WBRNPDKXoovTeda1RZQeW3z8w4x2jLU09FfDta/Usqn4O
 opDIcGYS2iUHQBBoPCpgU7EmO2TcywEWagAzMbEjw7+kf1F9cRVH27imEM7IMK5Sz81sB
 r0XbhJBNO5QxQ3quNpheNs45QPevqzCSuJsrVW3g17jyoVbOpuC11TCIZkfb78BDy3FNh
 CcqhX6CkgjXWqAu7Vr+ulbdoDJLAfRPuzImNpuvE9T+mHjjLxi3Y6uj8KMzB7GSNrGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="hoR77wC/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BEGXKAtX; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hoR77wC/; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BEGXKAtX
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1767C80C25
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LBg7kf3658160
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5QXBAZIk9B1WSPwgdYXiBPNgmVraFDu3I1/q+7ykt6Q=; b=hoR77wC/atm3wsgd
 RU1xN3EKALTPwUI5hlxcRfEGEVYVAnhejTObrbD5m80VqjyrQaC0tvy3TmWX16i3
 Xcg0d/FPWex04C1unaec3PyJwXKABM5RMsoQS6LtuckokMcicON6kL1O7pV0L3PJ
 RH6Jx4g15UllkdhQIrXdFDNFP1zWxH0hSCU9HL+5gABWCTCkcLbGupO+v5quGVj0
 jYAIripNHU/ElQaMZY4Rk2t56eL/B6er4ghwJ4pf9f+KrmxyDCX8SIzBoeVHq/0k
 DxynuYnEkEb2ivV8dAl6GSGErHk0pFGezDQv7xcr3FQVbfTnze/1kaIjLc9IVilt
 1wdZlw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9brwc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:54:14 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-147be78cd56so2351154c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792587254; x=1793192054;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5QXBAZIk9B1WSPwgdYXiBPNgmVraFDu3I1/q+7ykt6Q=;
 b=BEGXKAtXUdnNflegeC7O+yL4j2ohtqLBSeTEIOphVX3R1/e7qiODyDhtcjLKu7YLh2
 D+ANB8jpjQI4mqdcJGq2KkfBfKoYX9cip7fk0k4ABN1NLYxDbL7BR5gMcj2xq35zySjS
 SWXfE/a5xAqNL1fUgxvUqbx6dgjkmEaStQd0TAah4P+nyP7MjFsQNhXNQ8Qm/8H7DB3E
 IbduKRBBUfvGGEYqifs3z21JRgzPdUfGXZMsjIabVej4LPP3UPdozXZ7NWohvl0e7NdF
 ohtuKCUTT4nm5PWh4fCg1lE5SJ5uIUNHEwpXnHNWvpR/8UDSQWUJGlp4RQCYNgSXlOqt
 yPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587254; x=1793192054;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5QXBAZIk9B1WSPwgdYXiBPNgmVraFDu3I1/q+7ykt6Q=;
 b=jCgPpUkldtmqyDsa60ZUJSr2WUoOSTP+FuUMsMRCsVyqnK2x5XQKhRS0LP/K3V2496
 MWI/MEYOodwzpvUC9+xZF0bPu1fKSt3HJL2uMGKa2nDe88l0jeQJGV4ZZ38ACfj0ZE2N
 wXXvxm4RB6PVJJQTM1aBu73e02EYzwMgHrs3VGCqk8r1O6naJ3jXjAu3DUHS86pAs54J
 sAGUh7ii/IduOnPRyQnc37ZslAOQy1gE+HZvJeNH9tVLsCCGITADdzt88Ctvyb4+ZQHF
 FaWZiT0/mfyulJZyuueDSDC490LHZgrom6rIY/Lqq97HIU+byuxu39sc42B4Y1LYeS30
 CCQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9+I2kRPl1aeSbVlvHW9GKEmOSFAvH5AWUi15I01TkGhRmEOUMr4/HIQ86YhsTQAfuquhRH7A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK0Zm06FLz0EQVgGLHwfHxN6iprTjy1JZzJtnueabAqomQVU+I6
 S8Cs67MLCVYBEOh8lUQ/jW8fCVAM+56WVkcFdYYn8d0W7tv3Gt+RRFrF/JEyV4yNYGuBQXGzjGc
 5sbFFWzAiQYUbUZjCPK02jB2DemubUIgarIft+4AppSJmt8jQuuSb9w7LXkmUw4Qo3WXo/zo=
X-Gm-Gg: AYBFou1oOjO4XsbQV1Zmwi54f4Hx00AtzzUnSl8/pj3zI/V3wwhK2zEvQB7qZFfqdxQ
 pJANZXl0IPs92Ep8zIKhTgh8J6dn0wBXBN98wCkvyLorg1XicLvq7euB2UWRsSYKp3XGX4zMFTV
 4nGxW85U1ojAjxmEctaDPyqMbUl8eyFBfJqPVfsg6hCgmdeTrSlu/mL86zEI+f0q6CPMZ4u5Lrp
 xyfQkK98PTdYr1qR951KrKNKgZOxC5B02bL08fI5rxWtW49X4xXXsg7GLKQ5FV0gIyx6wtuZ+L1
 DT8aaV+/zuPSXPWh0KQJkvmvD8gINjVeKt+zDPHOrnDj0Gsty1at5JOrCUmsND1jVs50TTR79sw
 iGmgaToPK61DEjcqYyQOsA4VX+FlYa1eNG1VgSJIAHTYv
X-Received: by 2002:a05:7022:b045:10b0:18a:d7db:f76 with SMTP id
 a92af1059eb24-190a8f51eb5mr2490553c88.36.1792587253547; 
 Wed, 21 Oct 2026 05:54:13 -0700 (PDT)
X-Received: by 2002:a05:7022:b045:10b0:18a:d7db:f76 with SMTP id
 a92af1059eb24-190a8f51eb5mr2490510c88.36.1792587252758; 
 Wed, 21 Oct 2026 05:54:12 -0700 (PDT)
Received: from [10.152.192.83] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903ca044d4sm6377675c88.17.2026.10.21.05.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 05:54:12 -0700 (PDT)
Message-ID: <be3b6542-f315-4c82-9fd2-b60be39a9969@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 18:24:05 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] i2c: geni: Add 32MHz clock and chip probing support
To: Heiko Schocher <hs@nabladev.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <20261007174151.2590649-2-gurumoorthy.santhakumar@oss.qualcomm.com>
 <ec34c46d-519b-964f-1d64-4e32d841ce54@nabladev.com>
Content-Language: en-US
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <ec34c46d-519b-964f-1d64-4e32d841ce54@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfXxkFVA4TlOxzc
 RsXHXQlK7iWaU5CgVcbdFfk5EGGopYxU2wPjZXrwZv0cA/kp8umb5X5bfGr+5vzdx1pBzCy8aFb
 kt7kpoHa8Ezl7re4Xuqtw2i3vmQFDd0=
X-Proofpoint-GUID: l9QNlhsqMYB4pWnyHvUuEmdfBBCXS-M0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1MSBTYWx0ZWRfX3gZUkrjihzw+
 jRJ6DsKAlj8jFgxpDDzBUgXofnDfQ+Cs2H0972KqMBehS4OUf8FfFhl8xokjvZ2tpe0pZ6PaQY9
 pRUH2h2sTnGHCcDiUdmOp9a0OAjkHhCWTJnu1WTBJDglsIQvvoRSGuyb1YC+1WGdaFygq8KDhMd
 2h1bfNo0v1zDBQ2CTF5HmNi9ncWD2hF5lmkbioSLBQcAhqf45rJunrX55eofy9Fj1vUhlko6SXH
 mWbwAYoUbFL4BaPWCVOEIHl8dbCnnhy4ypze0+CW7Y9Mv7KfhnDeyn6u98YJpYsX9ZQFmFP0L1t
 szvkpaDWXjNy1vAzkbsY8EqGuTf8M/5ghgKNylttjtdxbLw0ddpJkpeYO6it7K5/4vC00iyT1s9
 wmAkNEhiQd97s2qQ6m5isXzRP+9NPMVejFI5S9x3++UUv2kZQC6Fx8IqnhxBLZ0YOl9YlSruxWh
 2CDAoYXzoF2B8JbXtwA==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad8b5f6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=oparXEaGMrLl-ryp3CUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: l9QNlhsqMYB4pWnyHvUuEmdfBBCXS-M0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210051
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko Schocher,

Thanks for the feedback, I've addressed the comments in the v2 patch, 
please refer [PATCH v2 0/7] i2c: qcom: Add GENI I2C support for IPQ5424 
- Gurumoorthy Santhakumar

<https://lore.kernel.org/u-boot/20261021125003.2948090-1-gurumoorthy.santhakumar@oss.qualcomm.com/>Regards,
Gurumoorthy

On 10/15/2026 1:51 PM, Heiko Schocher wrote:
> Hello Gurumoorthy Santhakumar,
>
> On 07.10.26 19:41, Gurumoorthy Santhakumar wrote:
>> Add support for 32MHz GENI SE clocks through dedicated timing tables
>> selected via the qcom,geni-se-clk-32mhz DT property. Also add chip
>> probing support.
>>
>> Depends on:
>> misc: qcom_geni: Add minicore support
>> Link: 
>> https://lore.kernel.org/u-boot/20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com/
>>
>> Signed-off-by: Gurumoorthy Santhakumar 
>> <gurumoorthy.santhakumar@oss.qualcomm.com>
>> ---
>>   drivers/i2c/geni_i2c.c | 76 ++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 66 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
>> index 7498cbcb41a..9edba3dd551 100644
>> --- a/drivers/i2c/geni_i2c.c
>> +++ b/drivers/i2c/geni_i2c.c
>> @@ -96,18 +96,35 @@ struct geni_i2c_priv {
>>    * clk_freq_out = t / t_cycle
>>    * source_clock = 19.2 MHz
>>    */
>> -static const struct geni_i2c_clk_fld geni_i2c_clk_map[] = {
>> -    {I2C_SPEED_STANDARD_RATE, 7, 10, 11, 26},
>> -    {I2C_SPEED_FAST_RATE, 2,  5, 12, 24},
>> -    {I2C_SPEED_FAST_PLUS_RATE, 1, 3,  9, 18},
>> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
>> +    {I2C_SPEED_STANDARD_RATE, 7, 10, 12, 26},
>
> value changes from 11 -> 12 ? Why?
>
>> +    {I2C_SPEED_FAST_RATE, 2,  5, 11, 22},
>> +    {I2C_SPEED_FAST_PLUS_RATE, 1, 2,  8, 18},
>>   };
>
> You change here the values for I2C_SPEED_FAST_PLUS_RATE.
>
> Have you checked, that the frequency is still the same with this 
> settings?
>
> Ah, I found your settings also in the linux driver!
>
> It came in through commit
> """
> commit a815975cbaeb4ab29f45312ef23be2871b2e8b82
> Author: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Date:   Wed Jan 22 12:16:34 2025 +0530
>
>     i2c: qcom-geni: Update i2c frequency table to match hardware guidance
> """
> I see this as a seperate patch, and please refer to the above
> linux commit ... sorry for this nitpick...
>
>>   -static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni, 
>> unsigned int clk_freq)
>> +/* source_clock = 32 MHz */
>> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
>> +    {I2C_SPEED_STANDARD_RATE, 12, 9, 10, 26},
>> +    {I2C_SPEED_FAST_RATE, 4,  3, 9, 19},
>> +    {I2C_SPEED_FAST_PLUS_RATE, 2, 3, 5, 15},
>> +};
>> +
>> +static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni,
>> +                unsigned int clk_freq, bool use_32mhz)
>>   {
>> -    const struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
>> +    const struct geni_i2c_clk_fld *itr;
>> +    int array_size;
>>       int i;
>>   -    for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
>> +    if (use_32mhz) {
>> +        itr = geni_i2c_clk_map_32mhz;
>> +        array_size = ARRAY_SIZE(geni_i2c_clk_map_32mhz);
>> +    } else {
>> +        itr = geni_i2c_clk_map_19p2mhz;
>> +        array_size = ARRAY_SIZE(geni_i2c_clk_map_19p2mhz);
>> +    }
>> +
>> +    for (i = 0; i < array_size; i++, itr++) {
>>           if (itr->clk_freq_out == clk_freq) {
>>               geni->clk_fld = itr;
>>               return 0;
>> @@ -262,6 +279,38 @@ static int geni_i2c_xfer_rx(struct geni_i2c_priv 
>> *geni, struct i2c_msg *msg, u32
>>       return geni_i2c_fifo_rx_drain(geni, msg);
>>   }
>>   +/* Probe to see if a chip is present. */
>> +static int geni_i2c_probe_chip(struct udevice *dev, uint chip_addr,
>> +                   uint chip_flags)
>> +{
>> +    struct geni_i2c_priv *geni = dev_get_priv(dev);
>> +    u32 m_param = (chip_addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK;
>> +    u32 status;
>> +    ulong start;
>> +
>> +    (void)chip_flags;
>> +
>> +    /* Add delay before chip detect to prevent the bus going 
>> undefined. */
>> +    mdelay(1);
>> +
>> +    qcom_geni_i2c_conf(geni);
>> +    writel(0, geni->base + SE_I2C_TX_TRANS_LEN);
>> +    geni_i2c_setup_m_cmd(geni, I2C_ADDR_ONLY, m_param);
>> +    writel(1, geni->base + SE_GENI_TX_WATERMARK_REG);
>> +
>> +    start = get_timer(0);
>> +    while (get_timer(start) < I2C_TIMEOUT_MS) {
>> +        status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
>> +        if (status & M_CMD_DONE_EN) {
>> +            writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
>> +            return (status & SE_I2C_ERR) ? -ENODEV : 0;
>> +        }
>> +        udelay(10);
>> +    }
>> +
>> +    return -ETIMEDOUT;
>> +}
>> +
>>   static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg 
>> msgs[], int num)
>>   {
>>       struct geni_i2c_priv *geni = dev_get_priv(bus);
>> @@ -468,6 +517,8 @@ static int geni_i2c_probe(struct udevice *dev)
>>       ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
>>       struct geni_i2c_priv *geni = dev_get_priv(dev);
>>       u32 proto, tx_depth, fifo_disable;
>> +    u32 clk_freq;
>> +    bool use_32mhz;
>>       int ret;
>>         geni->is_master_hub = dev_get_driver_data(dev) & 
>> GENI_I2C_IS_MASTER_HUB;
>> @@ -538,19 +589,24 @@ static int geni_i2c_probe(struct udevice *dev)
>>       geni_i2c_config_packing(geni, BITS_PER_BYTE,
>>                   PACKING_BYTES_PW, true, true, true);
>>   -    /* Setup for standard rate */
>> -    return geni_i2c_clk_map_idx(geni, I2C_SPEED_STANDARD_RATE);
>> +    clk_freq = dev_read_u32_default(dev, "clock-frequency",
>> +                    I2C_SPEED_STANDARD_RATE);
>> +    use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
>
> Hmm.. this property is not defined in linux code... do you plan to 
> push this
> to linux?
>
> It seems to me, this is not needed in the linux driver at all!
>
>
> Could you check, if you can adapt geni_i2c_clk_map_idx() to the one 
> from linux?
>
> They get the current clock from geni_se_clk_freq_match(). Is it 
> possible to
> port this to u-boot?
>
> Thanks!
>
>> +
>> +    return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>>   }
>>     static int geni_i2c_set_bus_speed(struct udevice *dev, unsigned 
>> int clk_freq)
>>   {
>>       struct geni_i2c_priv *geni = dev_get_priv(dev);
>> +    bool use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
>>   -    return geni_i2c_clk_map_idx(geni, clk_freq);
>> +    return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>>   }
>>     static const struct dm_i2c_ops geni_i2c_ops = {
>>       .xfer        = geni_i2c_xfer,
>> +    .probe_chip    = geni_i2c_probe_chip,
>>       .set_bus_speed    = geni_i2c_set_bus_speed,
>>   };
>>
>
> bye,
> Heiko
