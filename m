Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3953BCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6935880C3B;
	Wed, 14 Oct 2026 12:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mBlcK2ctdPY8; Wed, 14 Oct 2026 12:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8259B80C2A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791982296;
	b=RFTK1gZS8k1bmE44pnjsdc2Zy7U29CWSdDc9mgmDJ180lxduFpjOup8m6gj1MuQ9Xi1Y
	 i7deBT/HjjboMNFu/IAOpM863isqPJi4aeIM/weEP0VCrdkH9jy5VS5JNrhfl48Xh9qmb
	 CiChDo8PuDcOulbZWUTV2xcprTMIxzgy9L8TbMUXS2pc35aHaURS17mNXj5yKtZbCB+ee
	 96h9sczBUTLL500b0w9n/S65JIldKQ+1yy7HiXIaxIuqdKLIVmYPEHSLrmQRwuZXVd+GH
	 VaiWg6sOx41qhRafRd3pcMGwJPAT1GD4jJfeLhNTgAQ3K8inv0EAPVjLGRMcEBXKAJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791982296;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6Uv0tpdA43dUwt4iopd99Tvr/IxhgUIbGGBMXl+3m0E=;
	b=lxAR4iesAMGFqgNStBztKFu5tE2y9GAI38Wu7SKPNVxCb3kxlyj+zl38k8+JkZZC+0tk
	 VP1+UkGgbiePde9fbfiOP4AfIZGw8J5MqqZHRnVqq6X3nbXwPlOKfA/qqA7ICl3sEsdTD
	 lqntqRBJn9HMD/Pa1no0ZZCl8nOIIdQNXfga7aeSaLVPAlcJhREAtjud0zfi//hnPAHTh
	 eWRzt4z92kB/gmBlV41aWyyxvq7eOdkQtifrHyfo+y9U//+16LS4NU6QpFqeKNvXXYqli
	 8Eoa4aCIT9OUE2RTFcX+kv6moPpmSMsFk2WCs4b32fnv8GkmZxUghPjt0DFnErmDqRg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791982296;
	bh=6Uv0tpdA43dUwt4iopd99Tvr/IxhgUIbGGBMXl+3m0E=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VY7NWnvl3YX+OVO8asWD+dxOJcIzfINTyt9FuNIOTzS4SGtyDtMAEL2teNIfJP5q/
	 hMcN/5lECnze7ti15Z5bn8zalT3QrYa/cMm5qj08kmXt/UukaAiv1drX8+RBfDP+b2
	 rH1EmWDSRf7nQUjsn8CDo2SF5chErho3/EKkq4Z//YnsacaJzf4mCT0f0Cm0+2KeaS
	 4Nh3XC0m8144ybHK4uHyhbPqCxKbnM35lzWNYotshX8oWY8288fMGKDxo87s/tHIQc
	 AoxVOsZIGP192EeIJJ236JV+rsUTQLIb7jAElKixOW2esbbs7TSpx/puWuWkk++YSA
	 4aN7oQKrn14gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8259B80C2A;
	Wed, 14 Oct 2026 12:51:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A80B1DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C4434031E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aseRFa952nJ0 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:51:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 421304006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791982294;
 b=ph4naC4s4mT8xPwfeSxQR0GieGahLOnA9jSWdkfM0d343wdFZfZlzthZ3ZCgtkWnhBuA
 +eWMo8tpjrjk9WwwBLejHIQMB8O7m+K2alWmzrwFQ4r0wQwrACCStM51N2rZeokSaNoK5
 UtdI/wOWNJl7mEHh1i71DlJbOp6EUv6+25x8GBlyuDZwbY55r5R1bXgj0Lub/gl8mOQ3i
 wtwf/5J0TO4iL8kfZUbP01ZZcadZHUF68dL5dyATx40MfYF/CATJR54+9buORroQe+tOA
 5CyUBNCM+HPvodGJPzCow9cr5xcJQoIV3GqTpMSt+ooKRL75wKavQPXicsnrFuxtjCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791982294;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6Uv0tpdA43dUwt4iopd99Tvr/IxhgUIbGGBMXl+3m0E=;
 b=a+EImS2ENmaw3D49RmoBLZ1acDpJIaarz0r6ADWlAziqXC1t0Q4Rfh3sCYc22vEo3xMA
 z5GpJnqFBtBfXrB+SUvQiv637RmWRVK8fXvQSkYOX7Cf31fTZOYUpDHcszeNu3w/yFUwN
 cN9nZxk6ydMnn44f/mNS+SZY+G03DxAvqYIMJ1eHO7/qR8zWzIRhNeOaC0YLYushZyl+U
 byA7XLvhbsfF/9E7X0H0s9auDsnzRnzOm+FNQqcJBl7PYeBWDUk2ap7F1D3ZYHtcbVAQM
 NE/Y81uA0zQt0JRdLDY8RksL9E/uiV3wqmU3Ni/w+rG7UUNIJ+x+XiWrM2jDHViDjUQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=A1nWx73W; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VOi8hzyw; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=A1nWx73W; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VOi8hzyw
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 421304006B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:33 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EAR4O4466270
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6Uv0tpdA43dUwt4iopd99Tvr/IxhgUIbGGB
 MXl+3m0E=; b=A1nWx73WNxXhwXeEQyndQAq2ixSAAkmd/zyoyF5+dejvPAVXRkl
 7R89CrYp+3Iq9/be4OwF1GYV59202kFKZzb3l4WWnMtgq2blPW5h6BdoigO5oKFI
 diYGk6h01gyBJc+1K096yvNc6pSY6x1ZRQ4rZLFt8EkOmH/Xnyz9KqlufbrRCWbw
 B8ivH9kH2ExWuYBNdGwbI9GDe4lJ+OnsQUqMDJ6cRLezXRsuBmFjGSbQq6y1tIxW
 FJc5RUfQUszv+Qs1zDjA8wMEMbax9r39mYXYrk81wfv2RQ2Ot9ArXUPSXn8yRpJr
 Y0Xe581cK+cuaoh79AmNOCubE5oY55micOw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80crgs0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:51:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3552883bd19so6933194eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791982292; x=1792587092;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Uv0tpdA43dUwt4iopd99Tvr/IxhgUIbGGBMXl+3m0E=;
 b=VOi8hzywqRi4D3VOaLu+O0XA74IrV3b0x9p5YMRCcf7bYe3396hCTalKT4C7XatUvt
 TbXV57sCxSzspbeB0AL2owfe7ci4zBeFiEm65iwo4qh7Qu/SpLla2qBeWPDRKglRG0T5
 UaiSKChzGHuqdeb+vHkbsJ2RoEeoxHB1HC/exkGxFwZCT3A6f31Nfb1d+XfJ9puG4drI
 yIedWfOYETlUarq6TiAGor+gKgMWgoMHoxJ1Z9Kwe3dXVfipBjocixycy7JSZOnebyE8
 5HHKxumBJiNqD10AASKEx+kzLL6G2pip0pctoBpEWjLxFZpZHzrF9HuQKF0QsuFZYysb
 /E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791982292; x=1792587092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6Uv0tpdA43dUwt4iopd99Tvr/IxhgUIbGGBMXl+3m0E=;
 b=vsLdhePzcSEqBxXisyY3j8ZAezKfRvzj7jrA0CMdvmT6H6K8EsOh7Sax3rScIh+NXt
 YB10bPXEZzQ3u59LEt0sZzJYpI/0yB/mxQvHxMKiqshsYx6qmSvd10OIaXC9LOAXd+36
 DF0nOrZaROIBsr+TksCbalS29mt9XXy+k4kjGaiUFatg9Q1UgFD/QhTEXyevBaPHnRRr
 l3HcWeZ5LBMjlAKdbNbcWT7usGnl7L0TKmLRk1dA5XVef8bQkdXjK7V6iOIYAuFkUWxj
 wtI2sK96VU6fVAl2x6nkWKpB3SusG021jbdNE5IBS578QygGFzeXHrSnwfzaqMqUOlGT
 M3Cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT9Yx7lPb58Smw46xQxKjG3sD0NLOGTxsFuLziYGxI59xrCvu+NUE11mzoA0SGX89EyFrT1gs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ0RTMmT+ylGArzeDJvcVAAvXgP7lP8ioAo2emCqXXR+NqNTKJV
 roA39FTRZTVDXzkFh4Fj6YMb7RjBIhlNLsnPDgxH5BtO9hoD47qODRSIv2LzTLKZ3EE4KSjMInn
 SVftik2d2th//MvZJZquM6zYo/Z6Ft+jt4BbsWphhpSXodmp8VaVV4AQHlTtG2AQgQycoDnk=
X-Gm-Gg: AYBFou332iJCJrJZJhfb3cZ1BXYVjU2Wu2dyjqIKIZncvHaB8toAS9R6jexDK8Hqy0L
 Yq3ZjE6IPmCplUnCRu0S6Ij2u5OrG0nugxb5P1YOMYk52jzbaOZ9+J30HsntaDKlBYV4jRDXriN
 u13FgosbS59djDK3ZBi1HHVycAyXgMVh2kJdh4b5OsZSbidViFrq1I63ONaQTn3VKMeR0EkAvTA
 Qh91Ag0JWf987nzgu+qtAlxMQtmU9qanyItTa2T6TVZWFy4dAkgeqyOufX+QsEwj/JJM0hwMvDM
 h0bYM/2NxXFtAgjH7jjtT3BaDLr0RJPczhAvIH7WTeD1Q253wW6EjkR4/EYy6UuPyeOH0J2Sc5H
 HqTgPa+iRjV01iPthBYrH86b+bkdm9kn9Y1fzuSSX+3vaDaY=
X-Received: by 2002:a05:7300:ac81:b0:34d:de2e:1fca with SMTP id
 5a478bee46e88-3537dff5a5cmr32478793eec.21.1791982291485; 
 Wed, 14 Oct 2026 05:51:31 -0700 (PDT)
X-Received: by 2002:a05:7300:ac81:b0:34d:de2e:1fca with SMTP id
 5a478bee46e88-3537dff5a5cmr32478752eec.21.1791982290857; 
 Wed, 14 Oct 2026 05:51:30 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm59713782eec.18.2026.10.14.05.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:51:30 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 aswin.murugan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 kr.sowmiya@oss.qualcomm.com, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1 0/2] qcom: spl: enable CDT for shikra Add support for
 loading the Config/Chip Data Table (CDT) from eMMC during the Shikra SPL boot
 flow and registering it with QCLIB via the interface table.
Date: Wed, 14 Oct 2026 05:51:23 -0700
Message-Id: <20261014125125.711084-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX1wKbfWJo+kpH
 ZwCvu63XCUgssHkvT5As6HyPFgTTG4egXYW8YFqghPhEEmFiPKfsVJkOYzhq1rzem72kclAUv9Z
 XlGfiySH53daKrPaLCjJJ9SObXsYIeM=
X-Proofpoint-GUID: Wr_MAy-b1ZRdmdZVZfpY6GMSkNhsTXWW
X-Proofpoint-ORIG-GUID: Wr_MAy-b1ZRdmdZVZfpY6GMSkNhsTXWW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX7BkekvfwCTei
 8+tSm7SMaZAIbmRqmYFlMU41PLDyRYrwLsrNFqj8ye0UXjI98riQuqwKI/DAYGhakqJNtKXJBAC
 AFHZvI/cm1H1C/a0E8XstLY31QZxYVZ+eZ8GmocvSc8MJXWWrgrZZA/15L8wRgFxl+wnLSgIUoD
 u3A85dv0yoTdkmzoftyKz06FZk5DSOk1QNnFWKceqW08ySLGx36iKIetMohg52ct6XyXdu72VLr
 Rauw3Ki1gpqPQXPmkEIGftHvZMs9U7EuM02/S7oUSGNC2Lm24XPBfrsu5PsEeBotp/5JCYdBJyj
 XwV7/HJ9MVtI3WUqaOxtrSfy6wIvDfKabyixJijB7m/MJopZHzUP6GFXQFDk0HiVXHZI8nqUa8B
 ZjypmVqnNqwA1vvr6P3f4Gj6YRVeKMWP7hKC8kgbBqRFYGF1yvA3LUgZgzKp88Y4gvtRzHmR4gT
 yK9zo4NINgu7VE02H2w==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acf7ad4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=9U8HI1bZefmV58vc:21 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ccmAHKitp5jFJfsW8VwA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140051
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

Depends on:

 - https://lore.kernel.org/u-boot/20261013053244.2954876-1-abhilash.v@oss.qualcomm.com/ 

KR Sowmiya (2):
  cdt: enable CDT for Shikra SPL
  mach-snapdragon: Kconfig: add CDT configs

 arch/arm/mach-snapdragon/Kconfig            | 72 ++++++++++++++++
 arch/arm/mach-snapdragon/board_spl.c        | 96 +++++++++++++++++++++
 arch/arm/mach-snapdragon/include/mach/spl.h |  1 +
 arch/arm/mach-snapdragon/qclib.c            |  8 ++
 board/qualcomm/shikra/spl-shikra.c          | 15 ++++
 5 files changed, 192 insertions(+)

-- 
2.34.1

