Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D512606A31E
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PmRusant;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pQg4KXQA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aANZ3JBh
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6315C80DF9;
	Thu, 29 Oct 2026 15:45:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVjEtMKFVats; Thu, 29 Oct 2026 15:45:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D405680E12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793288712;
	b=oMV0gmsiWTgKVOwFVECthrV0XeFmFLqAi/jn+42DwMxXhH0h2fAiIKXVaitn4GwrCzhV
	 mnbfd20ZuKZCeW6C46n7u9afery4LHD/H2DlMIxlImMOUgzNNe1JS6G4Nv/cy05klhsOS
	 w6uqmcWP7cYPU8y9WvA+LMazxMuwk2HBsDc9h/eDTmdwHZCRFQIMnvAILwHOhj3uBBQgQ
	 qUiM53ySWtbE4E4X/WB5z9QdCfAQ8zgqRut7YmjQRMsz/QT/DrwCGWCzqzH8uUZjWBn0f
	 e3CUTcTeDhMHW0UDGdgbXxKoeq4TUQdqBRiEt8sg4zuaIS/YF2sNID/Hrmw1uB+Slkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793288712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KtFjincUKWGtICvDTqNCg46rx9e0/JF4/oUPaDlVKqs=;
	b=lcmS24AIKjMvXiKV5icg1L9gPCegIdc1/ltiXiOo1bF7TYsZihFB7xhh/S8z3BPZn4z4
	 h6AUN5kQHYF0kpCbd2Oyc6K38ugXSg5pG3fCJszh6x7aAysxMvQGsWWGdmcKpob91BXBb
	 Oc0VXphhxzLzaL8mG58WAf3AI3BN93b5vhje1HSLjlWEq8EzhpBrPqshDznX4728Z6YXj
	 QqVaL3nf56Xjy8eeNxotl4bcf1OfkhpKg/iNZOog9nqNqmJU+deIxgoLxsVfosjzr5wp9
	 HfVRAd0+bC8/pUpthIGkavNngavezJRWYgLf4YmidBIInyEWIe6pqIhGTDatmko6I6Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793288712;
	bh=KtFjincUKWGtICvDTqNCg46rx9e0/JF4/oUPaDlVKqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PmRusanthoMrMOFaL+KMVVULkP5pJ8V08P+C2W/2LawN+ndxG2KIbJFb1V27dRmwY
	 tsaYf56jxIGJ4tH9sy8bMqT+G9wOTbd4BNiHsuY76CfZ9LxL+4IC38BGdvXncpnedt
	 /RsKq4uqx1quxJ423ipoPXiF2Jw0k1S1PkwGm8jXz3KwJrpdHjhIS1BT61gtnWby4X
	 XhNFdBjHMXVgH32zm+bQKsPc2J0Og7rSJVhbiT0PIG5Wtr5H8n2XwC2F8CF7EdifTD
	 CBuCItxGoIUlZmweZ/OmEc230hy/fNaQTLubBXmg9pTqxHEYE2Q9QPe9ZIZR8sJbWs
	 RffC/iG94xNEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D405680E12;
	Thu, 29 Oct 2026 15:45:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E673972
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D9FF40012
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_ZKxza2ZSJt for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 15:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E7E240062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793288706;
 b=JC7a1xDW7hReAu50dPgNF6q2UkTlYGGSQ5cZYWXoqJ9T+vEcC2p8CBTvFRT2Z+mvfa+y
 +l29Clp46yV26ig+lEkGbU7meWQ5854J3l+Qbzw0fvFwhCtx3EhzG/hOpnJEMgATjt8Jk
 8u0NgXldns9T14yFfPV1XcnntUi4mpfYYX1HvxnpkDfjsv/cMUxGeZbKlY3Y3eB15CEnC
 uydKTaOAYVs+/qHFeMrOBvi0cyjWUu/3hG3/LCAq1cbd9zVC3OOTUnKR/GnMYM6tMIDXo
 SRUFN+RFLzhHaIK5Lf0p2JGxzy5BonWSPnn84RETBgwX6NyjL7lu50w53vdPpyPjOfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793288706;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=KtFjincUKWGtICvDTqNCg46rx9e0/JF4/oUPaDlVKqs=;
 b=XL6FCwbwflXiXxjaAsEvCVdvKVpgfMsERSNIMIAyYdapr4kT0IRFkruYJw/K3JUJ0GE/
 TDlSZdU0KLzu/z3w+6Mkp4fsZutJ2HZhNcKofFqLqk2ouc1XABonCZpAnrVra9OETeizv
 hW8h2HoJnZTTHY2HIkfDaC7jggPFIHNRfMeJmixQAWuTO43MshtrBpyYj6zruCOmz53KE
 U36F2tWZbLHiD+3vdsCauDEo0SOOrdogtOOkIYP1niufhjeC2MQvOaDtz6ksecRIn8gjV
 fhZ0jcL29YMjOUc3O3SSFn3Q3/ve1BC2QrfVwvvwRKWid3crf8NkeAbRfIhn/Ujzy3Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=pQg4KXQA; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aANZ3JBh; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=pQg4KXQA; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=aANZ3JBh
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E7E240062
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TFCMIG397336
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KtFjincUKWGtICvDTqNCg46rx9e0/JF4/oUPaDlVKqs=; b=pQg4KXQAQy08vC1j
 QFGxq1FxCBSi44WAVcelStwkCnBGbusgZHcIDvKp6DEkeo2DfzWXAd5+FUaXt3/C
 CT0PFBSSxcrc4Y3E3+lenozUQ+V7P4f4D7SaIJVR6eL0YaKSypv68xS5sBeZZI/p
 92pfbJNcl7vBebKepuv2PK6V1Vmud0VPUJCcZ4DLsLBdyRkAV6ynjyICgQhJEROG
 aCE6upZAfCVNiIEOkd2LlAQ2+ogrt6z2qunDhTO0EFtzZ8uzA0eSyg8ODd3LZkaz
 yM2IrAqZ9h0AE/t3f6R7yQxoOWfF8Fx8bSRn5GO+WQCXtv+eXIR8FEVV2k8z2zuG
 sOLEuA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4g5x6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:45:04 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e92aad34aso424239685a.0
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793288704; x=1793893504;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KtFjincUKWGtICvDTqNCg46rx9e0/JF4/oUPaDlVKqs=;
 b=aANZ3JBh1nX1fXZzUDOaanfJfG92z+FQx3GRi2zfYGUc4nDllSdtvDgIMv4rARf5Wj
 0mqPXBLFNEqCJPHtR6c17ZamymQ5C+H+2hLh5LTg6qU1BA8sAT5fhGoQzAv3y0SqyqQt
 A+eTaAqV3stBVLANyyGW9Anwp0TtIt1ClVHPI1eYIE6JAtL4MhTwi1c/DuVOlENVKBL8
 9BnwedbdC1D0TK17ViBoyC2ZCsESu5l0N1A2O4AuW/5fFtTxlb1fxvbA93uhqqSqvvBJ
 FleNK9DcVIy70w6CoImMZyw2EAB38DNj5jdDzUWb3iNY+G1zwhfd/+EpxCp9dMsKwanE
 nnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288704; x=1793893504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KtFjincUKWGtICvDTqNCg46rx9e0/JF4/oUPaDlVKqs=;
 b=id+P3VVCaSzmXdfN29TR6Z1hZ/85Gcdz3Cxm3WDe0fNjJ+F7W7uD0XSYzzn3xWl8YT
 EWO1rFIIgEHCjlcxPNBp7uT9fUygo06Sa3kOL50au9ryIBjwU3YfHl59uSFhyUIgptb+
 CrPlhL0PELwWyR4q6lIFFWpIMKIU2QQhW4kGUpJkcOYznp9kStVIrHB5B8LN+oLl8yQb
 dW4otaVE7Kqqk7KxGuOoMig7OnPYA7Hoz4HQgbIUl3jx6vahZiZnMoyaxpHu+Kt5fqI9
 8tFjdV5nf6PhcaMDwgbWDdXgvLXX758amGcFlzPxuajxZW5GBobVNSEtBCLrVqojnEVj
 7qhw==
X-Gm-Message-State: AFq9FYIZquZ2HQvbXyE8aiUWs0xXOTugWv6f1DfaHXgbcpFrYRk8rJAP
 OsSR1p1+4TRsDVzOOlSY/sYVd2JnCsIXLedy5aUSPSmLXaW/FqCCeZRZQehLrOKvKu7fYgdLbYj
 LaHLa3QwvM4r2QoBON5DUDatMa/rBPBsnJvgdS2FSOQbag40Wn8j79weeSgsnZ1d+dwROEdLCE5
 BntqqbAw==
X-Gm-Gg: AYBFou1zK4lgusi7V23xdwIIVnCKu1EDd9KihuWUu9sTTijTKq5l9wPoQqp05v9HZob
 NRlIybDwBWYGW49riqJz5QkFniz5QUCIuwvsfqAPZZawDmzxfb769vVNOs5Ipo4TN2eE8wMwGHn
 q495Vv/aEsiPpzmyDpTOTD1W5tE1SPVRqDrxsc8afwnvQ9FPWlkHJwpuDSDRkVcTXwqIlCPwFnr
 qCct7Hxca3HueZxIET40aGVVE4Q6UXFfrduHcxqyEZrCA3lMh6SuuiYZdKn0dKXohqkKwjB3c+N
 5TJVUxN6FsUwz1LXk4gr4E3QuRgg4crLqGZsRUrRJ6WIiGtNskCXYinYK7TXFQ3YdjaORm1piUb
 PvTpw/eX7/ffaJuNpmtJpqPaS0kZeTEB52Sp/x6lvbSfrVaES5UxBK1+XT1AhZHqjukO2/Ts6nl
 7rdKH/hCQ00QPZ
X-Received: by 2002:a05:620a:454b:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-94408ccad5amr968640685a.49.1793288703468; 
 Thu, 29 Oct 2026 08:45:03 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:93c:6e1d:96af with SMTP id
 af79cd13be357-94408ccad5amr968634685a.49.1793288702850; 
 Thu, 29 Oct 2026 08:45:02 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b496022e91sm2814338a12.12.2026.10.29.08.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:45:02 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 16:44:51 +0100
Subject: [PATCH v4 2/2] optee: do not announce RPMB from within a
 supplicant RPC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-upstream-optee_rpmb_b4-v4-2-e2e4c5330d37@oss.qualcomm.com>
References: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
In-Reply-To: <20261029-upstream-optee_rpmb_b4-v4-0-e2e4c5330d37@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX8Fa/i0btUroB
 H/GyGIiJzYmk4HvgbO0zQ5/SqGiDocLnotaDldi6wdXcA24tDe9Q554zVVOiffxuKj3YNGKUhqQ
 psfOo/DZud1fzAaeE42p3jiQCFcHGgoXE1j0RTCijWVBLLALE1AsE3Xc3vi4fUGcvnoO2hhh1Cl
 y47p01JuoEBTa/vurXjgsJ1wnAd3KyqSD4+W68hhAtEE0NUqVjOUrLv8GT1IxgbrDCSocgIUK8j
 b6aCr2dllfE0DgWEvXP1w6xXUsxkRluJ/6S5skA4t+EeOhrJrex0c7mUPy3iV2D+N9YjkfQHk9p
 VTcwe8zlc2QTNO5LhAtiF6pmV2DlkcMDWt/bATW6S+cwkOSb9aHwD4/6MTDyYQa8T0nNw3vv2em
 LUM7zRx5/L8JGdw/W0yDn7hukgQJzxCCSa4TWK3njaHEp76DLv/BvoXlx57I75zJ/zLeDPWH8mH
 40FNuinLCxfQKqYG2yw==
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae36a00 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZS74WLx_hjJgvOhAqwAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: P3CZx4UYF39VLvVaowIlnp8BNgGnN-TX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX9nua3Y7Mpf9U
 nrv1S71Y5WpIrzDwGsgajR49Sas+yAk1OyhTDpr0zKJnYtfcaOkCgouoAWdh5mqiad+rNvqqvhz
 zk6XS+N2TWGe9Odmf0XqV/q9uZKNB4w=
X-Proofpoint-ORIG-GUID: P3CZx4UYF39VLvVaowIlnp8BNgGnN-TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290061
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mmc_init() calls optee_rpmb_available() once the card has been set up.
When the first initialisation of the eMMC is triggered by the RPMB
supplicant, that is while OP-TEE is blocked in an RPC and holds its RPMB
mutex, the announcement opens a nested session to device.pta, whose RPMB
enumeration takes the same mutex. OP-TEE's second thread then tries to
sleep through the notification interface, which U-Boot does not
implement, and spins forever. This happens whenever a TA touches its
RPMB secure storage before anything else in U-Boot has initialised the
eMMC, for example a TA call issued from the shell right after reset
("optee_rpmb read_pvalue" with the AVB TA, "tpm2 init" with the fTPM).

Linux never runs into this: the RPMB device is registered by the MMC core
long before any TEE client, the OP-TEE driver announces it from a
workqueue rather than from an RPC, and the kernel implements the
notification wait. U-Boot serves every RPC synchronously on the one
thread it has, so record in handle_rpc() that a supplicant request is
being serviced and skip the announcement in that case: OP-TEE is using
the RPMB already and will find the device when it probes.

The counter lives in the OP-TEE driver's private data and is therefore
maintained in handle_rpc(), which only the OP-TEE driver reaches, rather
than in optee_suppl_cmd(): the sandbox TEE driver calls that function
too, with a device whose private data is its own sandbox_tee_state.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/core.c          |  7 +++++++
 drivers/tee/optee/optee_private.h |  6 ++++++
 drivers/tee/optee/rpmb_emmc.c     | 11 +++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a47c76811cd..f7670096b61 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -424,6 +424,7 @@ static int from_msg_param(struct tee_param *params, uint num_params,
 static void handle_rpc(struct udevice *dev, struct rpc_param *param,
 		       void *page_list)
 {
+	struct optee_private *priv = dev_get_priv(dev);
 	struct tee_shm *shm;
 
 	switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
@@ -450,7 +451,13 @@ static void handle_rpc(struct udevice *dev, struct rpc_param *param,
 		break;
 	case OPTEE_SMC_RPC_FUNC_CMD:
 		shm = reg_pair_to_ptr(param->a1, param->a2);
+		/*
+		 * Tracked here rather than in optee_suppl_cmd(), which the
+		 * sandbox TEE driver shares with its own private data.
+		 */
+		priv->in_supplicant++;
 		optee_suppl_cmd(dev, shm, page_list);
+		priv->in_supplicant--;
 		break;
 	default:
 		break;
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 5c72b280058..416fa66db4f 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -35,10 +35,13 @@
  * struct optee_private - OP-TEE driver private data
  * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
  * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
+ * @in_supplicant:	non-zero while a supplicant RPC from OP-TEE is being
+ *			serviced
  */
 struct optee_private {
 	unsigned int rpmb_next_region;
 	unsigned int rpmb_cur_region;
+	int in_supplicant;
 };
 #else
 /**
@@ -48,11 +51,14 @@ struct optee_private {
  * @rpmb_original_part:	the previosly active partition on the mmc device,
  *			used to restore active the partition when the RPMB
  *			accesses are finished
+ * @in_supplicant:	non-zero while a supplicant RPC from OP-TEE is being
+ *			serviced
  */
 struct optee_private {
 	struct mmc *rpmb_mmc;
 	int rpmb_dev_id;
 	int rpmb_original_part;
+	int in_supplicant;
 };
 #endif
 
diff --git a/drivers/tee/optee/rpmb_emmc.c b/drivers/tee/optee/rpmb_emmc.c
index d4abc48f764..a40573c9281 100644
--- a/drivers/tee/optee/rpmb_emmc.c
+++ b/drivers/tee/optee/rpmb_emmc.c
@@ -210,6 +210,7 @@ void optee_suppl_rpmb_release(struct udevice *dev)
 
 void optee_rpmb_available(void)
 {
+	struct optee_private *priv;
 	struct udevice *dev;
 	struct uclass *uc;
 	u32 tee_sess;
@@ -219,6 +220,16 @@ void optee_rpmb_available(void)
 		    !device_active(dev))
 			continue;
 
+		/*
+		 * mmc_init() may run from the RPMB supplicant itself, while
+		 * OP-TEE is blocked in that RPC and holds its RPMB lock. A
+		 * nested call would then deadlock, and OP-TEE is about to use
+		 * the device anyway.
+		 */
+		priv = dev_get_priv(dev);
+		if (priv->in_supplicant)
+			continue;
+
 		if (optee_open_enum_session(dev, &tee_sess) != 0)
 			continue;
 

-- 
2.53.0

