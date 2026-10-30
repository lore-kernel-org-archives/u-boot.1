Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15D606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Teqobl/q;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HfEIeG9e;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aWxaZNnL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1AB360668;
	Fri, 30 Oct 2026 08:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UkeG5s7Hhw7D; Fri, 30 Oct 2026 08:48:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EEAC760690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793350124;
	b=UNwf6iTG3DASrkYkrGu3nn9mM+Br85esd4bwgud0sBx98yCoNEx7YG0vadNdSWfZIQbh
	 01Gx1J5+O+p/yiHJQUudhEnE5Kko2zmC/DStjVh5LQyeNhXFYzUjhYnPyyvmwUK5fcVb0
	 fEmDLextVvKf93H+Ks1I/2RhyBGNet0kEupsvYaprqehj3aNH1ChVvPOZrf8zN69lLz8F
	 KIMDmk98jvzDg/ucAomdUWLR0AelOLH6tq4aKR1SrYjUrskcwsz+X0dbqqMS2HvcchUqA
	 fas1HEZb5fmKPXD5EO3fI/rKxAkSaru9pvQM9MKAI+pNRY+ilRxBNVJUolVlUGGZSEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793350124;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=unnZG3yGZQnT5xTCOhzv0+6ZwJYEaENjY03b/jSWkvw=;
	b=IoNBoDBLqv0divVM9oIdKkh0mSeiOreGxjWfg0JuhkbgHo7796ITrr9EaZw66+UM4/Gu
	 UvGvCy1bvMPDvKMOEtzJcrr/wDr5zNQKv1JYN8Q4a9mVCY5PZhrwJdokLwhakJtoJNCee
	 31s+lCmVLr2RT4DKktDouc4MIY3j5sOPhd8MxDkLBoaDYj8wHUPpmd9RHtvSulhRgBzbP
	 3zBLpx3/HrIGZkCXSUvNE+A468bROCyvWUA9RE8cdMagcFkNNXym/KpFlbxIdAMQwPabK
	 C40/c5P7+aOrChrOLkeOT/LK9U/ZdPTidQbnexKxPWPkPNSJv3XUkhch8zz8PIPy5pQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793350124;
	bh=unnZG3yGZQnT5xTCOhzv0+6ZwJYEaENjY03b/jSWkvw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Teqobl/qwKY5J9MIVKvny2QFVOC+DW7p2MnOZOEYctZkUYfbTuqrUzynkLLznQHPz
	 8iH2xA+WOUyy4e3ZYgZotIEUHysQlhbgz2EiySel2wAoaH2ffGaHgcQHOhYOmZMn/T
	 Ob64IiTSyV0r+vWqzQWSGNx3gkyTEG/n0i4KDtq+73zYvcGV2XZj1r5Z6/HUT/sFuc
	 qx1LBBETNgxPX//fSZJgyo1T7ZJrB8ASwVPyZRIeUcJGsfpro1mrov5hk/pQTEn41c
	 fHPKf0294Iv4L/oJB3llrk1phEjguffApDqJGq2yQt1OUz+PJL8H9jD4AiWeC4swKa
	 0gAlASWEvp7XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEAC760690;
	Fri, 30 Oct 2026 08:48:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B8235380
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9DD534016D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4mmDDKW0SfSi for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 08:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 42A3D400EF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793350121;
 b=o2rcvL/qnUGj3KX1BxrbmE05rQnTsgmP9cJLg1ANYf778BZ3hd2BkvqYUZC7zc9LDtuO
 pYG6X7SPP6xwnTmZkJB6QlZobkRXKlOFWOLt0in2mkh5EU3CvqTduSayIrajVgJ/2HLMH
 Z2Ke3CAhHEDJLEcQE0kSA3LL/tIlwBVGfmBBL8nQU2UrMjHCuHF65yWiCyvsyS04i82/0
 wzIfOSsdyGATkgCkAmyVigo+dakMiXw863z+07STQsuUdoluaAebPneWmauUrKE58v+EO
 JHGTH8VKhEqzwe2MK1uJxqrywFFlGulgGjLz+jrubNOkv08JClLRydhFtkmkqzBNA9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793350121;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=unnZG3yGZQnT5xTCOhzv0+6ZwJYEaENjY03b/jSWkvw=;
 b=jWnrYrPXY4R0ifV/fCXzhQfp1LlRnYMtO2lMgqsDs8r8BcwsFaxmk53VW9c8TQy0rAiQ
 +HGrSIn2Ekh6yAGsKpYU0O8HxLxDWWkYINMn1CmICL6iTZaYNqKzgiSgVUv/EZIt/FTHG
 PUFXKGnureR185c2rMEX4F9eZ1MaOaitZN8hTD2NRGuxy9L9DlTtdHAA4Dk9UAPa9Zqah
 msgxJRTHSGuHtiMAZ9Vt/Chse22r148bufrh5Zw+fRWDIiPVEPiY+AbIPBzrhoxSe9pu9
 Nwbdg2K16jxDZA2IBknzxmigkiKuwKLuyiKqZzxFdggEl2cgKxszBeEcC4vj/6YVK4A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HfEIeG9e; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aWxaZNnL; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=HfEIeG9e; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aWxaZNnL
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42A3D400EF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:48:40 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69U8EsVQ3737734
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 unnZG3yGZQnT5xTCOhzv0+6ZwJYEaENjY03b/jSWkvw=; b=HfEIeG9e7rrXjnBS
 t/888nhl6kG8orfa6PhVfC9dyJ+a3ifFAYqAliWSwHZl8gwelrIl8Yn52CeJxtaw
 cQe4xsW0PMLqnwSQ6bfVJ/6wLDpbQ20HvfYHZtgZLiFC05V0sV9GuS0GiCvU5REh
 f+FbMT6fqTPzxgOLLLChw3H26TN116DtWoy3Y2FUe1n4GFeaSVeudCLX6nVb5pip
 I8dj1vu/w5ISF3XvKXSJ7xBaC2h20pzLj7HJO7eApQehUM/5MqOcDEfjg2efLu2E
 YxBBlySaDq5JKUQOtNEisz2eR7MHC/ioXVswRGJZ5EUYPXYVfdrkLm5esU/N7Y/u
 kosTwQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme7520yj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 08:48:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36637676140so926857eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793350119; x=1793954919;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=unnZG3yGZQnT5xTCOhzv0+6ZwJYEaENjY03b/jSWkvw=;
 b=aWxaZNnLqJiz3tDm9raOvKc34mws73YZAbHibvTrML0JRz+mg8eId3Qv9cJMUyoDos
 5frXVItm/K4h5zBlkPxo3KxycP98n5yteG+edoomH2EJMMJLvBugKftW9BZ3jpI/7zkl
 VvGM8pHOC2w5e+oMJaUkSncrCztiDWQcNol0Lbxt7MXAnLbtdAhypLV05ZxbiP5/3XRQ
 Futc2RHwPabFYH/20xo9HuMKFOWjU4HYAcr26tYWqFmXqmXqcwdWaTw1/mAvp5lDhYLc
 QXPXGh5kIs5hOhezQ1GhJtSsWfBkVtOcTpWy59h4nL6tqgqNXYdGpAR/cG0+nXsvcu8f
 zwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793350119; x=1793954919;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=unnZG3yGZQnT5xTCOhzv0+6ZwJYEaENjY03b/jSWkvw=;
 b=H3ymWuQS/Ij6y56QCkz1xtLOY9OxcNpu7w3K1vje3CZS/WBaaQUdShmqbTMZtSoKkd
 X9bl3JFMDyNr6HKpRtASZdyyKih9vcyFDlgTECMcgIAJNPejcJyRzpDeWOyoVSUM5vMf
 +4nocgiwt3Zd71TW5KsMjPBT0thLV+7s3d9lsQ3WRRmpgHFvdTEzmbx7EkRzDZtyr/Gc
 w+Z4A/dv5vibzQ30cseli8Ie3oBg8X1owTuzYJKLJrlEBWdcUYJppczHwEAoFZwU0T9b
 c/vLKwdHHxun/opKZOZ4sWWsMiX+rm304VccmYebYN3XgpWpM5FSNOwid/Wh/lgnUpH8
 12sQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsd0ek4q+4WWVs+5zWSQ0hP2UVg9bfTduSL/2PaPnlOQrPQIxoiH7urv/NB4Iv7SjN9GzKDbU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIB3g6zdszJmgWlVWx4ELco0W7RkLCich9lKbJUoc50TKgZbt+v
 ggfhInjGuQucL+kzJVIAcRZ1kLiFYJb20Oyj0ZoZOlcSKCzf92jqvVLKak4wIJAQZKnlg8Or0j9
 P6nPB4YLahN5lTqoU8T5xoYMcA9V0OLOpBhhBqlMQ7aiVkWRCXZvaRrY+/4ZFhbTFpzyApsU=
X-Gm-Gg: AYBFou052m6MVkQZ1gAKnlOtwHl18BJDs+5GUNahlmqaE/gdpsoZv/szE+fIG0jrb52
 4Jt+1hVFOQWOrDBd06ZSsb2ZZHAzLo02MjyzPczdu7eZk1YhVfZOZ8MbqLQiqtNtPhSjYjd9TqA
 q+Ql24xYFhHYujdB5P31ZwzsZp3aJ6+yMOhU7Mw9no/5tO/oU/ho9veynb5ZfvjETBdsD8I8+L1
 CgBnlV5TU0XJEaf4SCsHv802OEbcj/ck4YQE5BdN0osBlin+RO61aOR7YHb+BXqKtFRWehX4/oK
 7rK4V+R1shT3fQnIq0hQps8E2SnKdM1UMSOp6SYbYijaeG+rY67+UHR+9gzAs4WM5GP7K16DesI
 kc0uzNVDyIrfKGAbJhRH9HxkIhUIztGP5EJkNdN5xntpuLmP5eKFcXDfTuurRGXCnRD/NyBdPU6
 JS0g==
X-Received: by 2002:a05:693c:4095:b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-36a4220016fmr3280212eec.2.1793350119061; 
 Fri, 30 Oct 2026 01:48:39 -0700 (PDT)
X-Received: by 2002:a05:693c:4095:b0:351:4d2d:af26 with SMTP id
 5a478bee46e88-36a4220016fmr3280171eec.2.1793350118535; 
 Fri, 30 Oct 2026 01:48:38 -0700 (PDT)
Received: from [10.152.198.236] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm5265390eec.28.2026.10.30.01.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 01:48:37 -0700 (PDT)
Message-ID: <5db157b8-1308-401a-b3a6-5f8898c4a6d4@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 14:18:31 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mach-snapdragon: Kconfig: add CDT configs
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
 <20261014125125.711084-3-abhilash.v@oss.qualcomm.com>
 <atBgyv6nTHHPNw6I@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Abhilash V <abhilash.v@oss.qualcomm.com>
In-Reply-To: <atBgyv6nTHHPNw6I@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lkPTQIe8ZNqgv3nlY5bb-jUqijLDk18b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX8vuhZS4pHnLT
 UzY16dsX+PAoJnWbR47LZzOGACrVAtbHRB2z0HYp/g6MIhxiNWk4mXYGSrJxaDlYDGNLdCzNyLl
 +Uz2vGUXyvQuXDk2nX5QoKK/13/MHsbHlpY4JRHimSl4bD3PJ/lJ1FZy35iXfhfyOV2ZI/iClGz
 xoJLzSclKVLIBD+sqMO+Nr0CusjZZV6LgEzk7eggFexxVahdPibmoYrARyAC7r4O1gSTGJwCpfR
 tqginhWxBVYvWF7Wpj/7q5RrB4TFYl6mMQJbvT7iNJ9Bd2lgdnFVIqcwA/CS+DeaFMYIYtbK9MC
 Mqj05NJo1jTwAuoQYN3TuzWzwBIEwjNGTEGhLK6RNGFsIcnevLEOzxYrE4YcIvODLj0nbqaJyCP
 KanbTb1BcB2CDGZoHHKdBPU+rWINVlURctGD0xw2rP/+dZ7r6cnVBlN5DqbmbExl/k+ZqDAMJUn
 nCwKJmVN+fgAfWqsk0g==
X-Proofpoint-ORIG-GUID: lkPTQIe8ZNqgv3nlY5bb-jUqijLDk18b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNCBTYWx0ZWRfX1x9vyrnGi60u
 cNsEu6c81DzO7GVzvkbDB1AGSkpKNc96yAR7UXC7Zn4NsHnzEFhOwKTIFptmO1E8YCDQxU/SIYP
 rOuZJXxfFW8h6tSk57nI0NXQIKMWBTk=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae459e8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8Os04KLxSkw47LDFokgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300034
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Varada,

On 10/15/2026 10:42 AM, Varadarajan Narayanan wrote:
> On Wed, Oct 14, 2026 at 05:51:25AM -0700, Abhilash V wrote:
>> From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
>>
>> Added CDT related config definition as part of feature enablement.
>>
>> Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
> Add your Signed-off-by.
>
>> ---
>>   arch/arm/mach-snapdragon/Kconfig | 72 ++++++++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
> [...]

Addressed this comment in v3:
https://lore.kernel.org/u-boot/20261029062431.3117727-1-abhilash.v@oss.qualcomm.com/ 

Regards,
Abhilash V

