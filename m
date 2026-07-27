Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8741C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 10:00:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AE2A406E1;
	Mon, 27 Jul 2026 10:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAxxFBhKPwM5; Mon, 27 Jul 2026 10:00:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44750406B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785146455;
	bh=6Qx4YpGjJbPKzlB8NxC4pTZtyvkFL87ITJoA6TQtIYg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=onu4onTUQkgGmKz99Xw/btGzl1x7BwnWnFsMwt3ZGGRDpcedEV/I0m35ziZ31E9Jd
	 TqYMI40dn0mXlSj1vszC3RCejrnwPQg1OOBM52Hc3VnKLf0IVlNiwOwP638dVSJwbm
	 HYfuXrDtHUCdNBqOrbZHs6GgFQxSGOH/2y5sVjz3K/Ct5XEobPcOPyRzWi4rH0p6sz
	 Xp8thoVNsh/L9+7q6sla94sKiFZSlzxACB9p/RN1ZZXWjJ7AlFPEbHi6NE3gK6s/P/
	 ZZP5GU8zQY8hanx9UVvjZjKGSnnewaRN/UF/1+JDXF/rmUZ14xwIMgQ3Ckatea0RmK
	 2zjD1R/zBkqHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44750406B0;
	Mon, 27 Jul 2026 10:00:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 985C0357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 822A1606D6
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2Cgfu1uDIwJ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 10:00:52 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=balaji.selvanathan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C3D2E606D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3D2E606D4
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3D2E606D4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:00:51 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D052D84671; Mon, 27 Jul 2026 12:00:49 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D917B82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 12:00:45 +0200 (CEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R9bYYW2846511
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:00:44 GMT
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4v68348-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:00:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso1933147a12.3
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 03:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785146443; x=1785751243;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Qx4YpGjJbPKzlB8NxC4pTZtyvkFL87ITJoA6TQtIYg=;
 b=a5dkIjxNjHhnczqjZhBdW8vwdWmF3GoXdpnl46FvxdtzGWHiijiSCGlBDx/mfaI1r2
 gGIzFg543VQAQqQBrRIzbtrFZ0p4gArf0lVudJIRfB5UBpe6hbN5c55YzuRZkQN4hC50
 geTczHCQnn0CDbSZMa9Qs10hZ/w4luRsG0K3499jU4mOhpe9wGmo65HDXleEkiB62uFB
 C2NZ0sLfV65xUac9Fs9DKFznZfJwbxBv4gBT7Q82PQ1axJITxv8RTpNqNaXuDAeJEBhD
 cLeywb+XtmOqMn4FOzXblKiDSGgLRQydE4goqthTjgFuZDhBoUY9B6tRezsgIa6wGGL+
 lFeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKnqoUDC1QycIrPhY2aLBtTRDaX1xjeLzbimf+5tZ0WurX+upQi4ASWIZAqiTXQm3rd5yUlB8=@lists.denx.de
X-Gm-Message-State: AOJu0YwYtaxPJ7+KBtfww3Z3+143hQ6nW5gQCEnm2G/63eZ1v9Frz5VY
 ASYG8kdppgPdGRHrZRz3FGPVwIDpfdXu5gGEeikojb0HEujTSTlaMpbzAGTt0VZ6wN2UrppVHjP
 ZmQkWSGH+dEte3NpblmJqbXsavOC0yDVkhduEsDN6SFGODE99lhHo3G4V
X-Gm-Gg: AR+sD10m25edUfMC+b2/ujqOTLe4dZsLvwZ9Kv/tQGeGCn+NpvGuqkY2gS83dUo8tYS
 1SWQnxc2qwdZ+laXrQq0t92sgGJCOSkK3789M9/dC5TSMaMJpDiialHIRISsRPqaiwiik95irYY
 tiWPJhnoTf5cyP/Xj1jIqLTlpmhdPP+VTiAks1NYUzxJyWW6jNJxq/JfS+zKWzepYftm0Kqd0qI
 Vs6l4iUHZbqDTexvv1QmxPr9l6ZKVpvG1l6uA8Ez4Gjw59g4K79PvfVyV+I4ekoU76knvAu4IJZ
 Tep8U25bffUJllTCV4y5d9KIh+w2w00YvqKOC1XVdWs/ZeHH/U9mhUAr7qv28fdLQwds2EcE5CL
 cfks1RO1RK4iwR3S0gl05OZHrs6xTskYwAWwq
X-Received: by 2002:a05:6a21:7118:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c67e05d50fmr6571079637.64.1785146443217; 
 Mon, 27 Jul 2026 03:00:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:7118:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c67e05d50fmr6571008637.64.1785146442498; 
 Mon, 27 Jul 2026 03:00:42 -0700 (PDT)
Received: from [10.151.40.41] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc5a67f3sm31624502eec.29.2026.07.27.03.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 03:00:41 -0700 (PDT)
Message-ID: <37b8a403-b299-4e0d-98fe-b4b3ae660b13@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:30:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] qcom: capsule: add FIT capsule support with
 multi-partition
To: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWjLQxOVb7H-Mib7NAYLmzumhL5uBi8dZ_ufCksJMrcQ8OQ@mail.gmail.com>
 <89329f38-d2c5-4014-a1e1-44ccfd09b3bd@linaro.org>
 <242ab545-c274-4b65-afa9-2c3ab056a918@oss.qualcomm.com>
 <CAC_iWjK_U_TtNJsXjgVggXa28iHb9212tEQEdQn8wK2XqXmJiQ@mail.gmail.com>
 <19959cc3-40f6-4e9e-801d-8f7c40edbf70@oss.qualcomm.com>
 <CAC_iWjJSNekv73X0n3G-qPjh60F88R=CHybxHzBUo1DDgGzrqg@mail.gmail.com>
 <37b24004-5080-43cd-923d-8db6d09f40ed@oss.qualcomm.com>
 <CAC_iWj+yLvqqunA_j6WX_0v_DSkf6xwXPSL+kysrUM7G3isSKw@mail.gmail.com>
 <8de79ca7-e826-4a61-b380-2bdf01c39871@oss.qualcomm.com>
 <4b344c4d-ef0e-4595-a6ff-10629cfaaa82@linaro.org>
 <936f99e6-bd6f-4168-bfea-8a8c777b4c52@oss.qualcomm.com>
 <6748951d-d720-46bd-82bd-19c4d97a6f20@linaro.org>
 <73fa32f5-0d10-4f95-a02f-2cac91d072d6@oss.qualcomm.com>
 <013d5bbc-983e-4386-b236-8c63f4406fc0@linaro.org>
 <aaeb155a-6195-4574-b4b4-fa7d6a88a00f@oss.qualcomm.com>
 <20feda09-ab10-43e4-831b-6a8647f5c62e@linaro.org>
Content-Language: en-US
In-Reply-To: <20feda09-ab10-43e4-831b-6a8647f5c62e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfX7tAapXmaxQ53
 0tF9Sne1AbGLjyn+HejA8orGFlN5cx/rWkiKtt24QIByNgXbeW9Mja1uxAt7sxrq6LHwLDyV8C6
 Xtzd2T+y53BHlXslbyO0cH+yWmLD0Ho=
X-Proofpoint-GUID: DAA3-OAKJcB_TuXRvcXrOIeAtI-rqbN1
X-Authority-Analysis: v=2.4 cv=ev3vCIpX c=1 sm=1 tr=0 ts=6a672c4b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=dw0t6H4-AAAA:8 a=KKAkSRfTAAAA:8 a=g5FJtQwP4xu_KA6Y-tUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=wVJa4CU9-Z26yuRAZDil:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DAA3-OAKJcB_TuXRvcXrOIeAtI-rqbN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NyBTYWx0ZWRfXzvkfjHbr9p6d
 kM1ugwrdeni7ptfnM6/yDYe09sYGx/wb3G5X5QKYgYgHRXt6UWxv4DzCwSyFNzNDityrnx+ULk7
 VV9Hb63B93x3pZQW8P0y2iktB2KLhYsbHlaa4F1ofEbGwP+HzbNTcXA3VTgxF4XOEfCzM7EM3ur
 6zGMuOm9SpoPosX7E0GzEu0utv4k/SpvjeFnbXWQHferY05HTCLB7KKFXkHH5J31o4JDgdYoT+t
 OqnyoqH/NLgdfpz4wZOfrGbIB7CmWWL0xe84BfXq44li3lTq4gIyin12kM1iwN8H2vCmjMRfv15
 YjUkI1QWKQ4UdRtK7h+YoPMeS32V1BVM6c587aQUiCE8X03TxwvHJFfr8UE0/tFd5tO/8W3ZeAq
 EqWuSfRQr52F7qfda0Z04ZefZk17unOVqx3RuIG/EE3Orr3YKK6o52LAbeKt1rwue3jG9wQglGa
 6Uj1SJCFfnSDI1X6fQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270097
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Qx4YpGjJbPKzlB8NxC4pTZtyvkFL87ITJoA6TQtIYg=; b=Sdh6jh2E2qfAOPL0
 0w7ik32wi2AWrwRlYHtHBWX58OGzbW+9GVTI+1GUDclGNXR6B0iaUopyy8IP9Nup
 MtRAeQ7kq5htl5cnzVh/U3g8mbiNQfeGcexP8TB7TdSpKGOjQfrgGQf5jxHlp7nL
 RNnmY7ri1DX50FSO4zIUIXIW5tNzTvcEVyhef3xgGla+GVGRl++AHiXwJumY1mT/
 L30RBfd/JrpDS2fPy1f1vgTOn4GnqzKKAuHh16Odf+OCrBbgr2XG9CClGE6asq6k
 aaAe7CmZ9+zb6STTF60n5oH4VVvLcO4sBr4jRWncR/dJ1Rrp0lMw634VDKsSw3Ew
 90uaYg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785146443; x=1785751243; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Qx4YpGjJbPKzlB8NxC4pTZtyvkFL87ITJoA6TQtIYg=;
 b=jYMrSF1n3HZZpYMP4iGSG2k69ltuZEW1yWuuoFGciMLFMiOaT9/AnBioBtFCaOmxQI
 6t9l8UP4G/Re1LwVXUaXMByFz46jFxGIvTwPyGiiJH9uea/IVT+ch4Cz8VOHNtmWshJc
 Yb/0g94Pj711XPsDUsowgzHM2PvGuZ1f4VrpvZ+nsxvX06W7V4VRmsV24GB8xVpifMJt
 LD8NmvStMWWSXl2IUKhD89HLo2we/8RdnIWuN8QfU20CArwd49/PBjgVle3LcRHq32CV
 IKrtfgv0+AJ20mJuVDyb9rk7zk2L2lCOXzqpgaDWi85s/gIBxD+Hy5QFphoicnf+lC3i
 RI9w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Sdh6jh2E; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jYMrSF1n
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sdh6jh2E";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="jYMrSF1n"; 
 dkim-atps=neutral
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
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Ilias, Casey,

On 7/24/2026 12:37 AM, Casey Connolly wrote:
>
> On 23/07/2026 18:43, Balaji Selvanathan wrote:
>> Hi Casey,
>>
>> On 7/22/2026 8:19 PM, Casey Connolly wrote:
>>> Hi Balaji,
>>>
>>> On 22/07/2026 11:23, Balaji Selvanathan wrote:
>>>> Hi Casey,
>>>>
>>>> On 7/18/2026 4:19 PM, Casey Connolly wrote:
>>>>> On 7/17/26 18:16, Balaji Selvanathan wrote:
>>>>>> Hi Casey, Ilias, Simon,
>>>>>>
>>>>>> On 5/26/2026 7:05 PM, Casey Connolly wrote:
>>>>>>> Hi Balaji,
>>>>>>>
>>>>>>> On 25/05/2026 13:24, Balaji Selvanathan wrote:
>>>>>>>> Hi Ilias,
>>>>>>>>
>>>>>>>> On 5/23/2026 6:23 PM, Ilias Apalodimas wrote:
>>>>>>>>> [...]
>>>>>>>>>
>>>>>>>>>>>> To support multi-image RAW capsules, we would need to:
>>>>>>>>>>>>
>>>>>>>>>>>> 1. Enhance mkeficapsule to create multi-image capsules?
>>>>>>>>>>> There's an equivalent tool in EDKII that can produce a capsule
>>>>>>>>>>> with
>>>>>>>>>>> multiple payloads. There were also patches posted for
>>>>>>>>>>> mkeficapsule,
>>>>>>>>>>> but need some minor tweaks to merge them
>>>>>>>>>> Can you please point me those patches? I did a search myself, but
>>>>>>>>>> couldnt find those patches.
>>>>>>>>> https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>>>>> sughosh.ganu@linaro.org/
>>>>>>>> This patch you mentioned here can create capsule with only one
>>>>>>>> payload;
>>>>>>>> means for multiple binaries we need to create multiple capsules. I
>>>>>>>> have
>>>>>>>> also asked the person who made this series to respin, but havent
>>>>>>>> heard
>>>>>>>> back from him.
>>>>>>>    From a quick look it seems like it would be fairly
>>>>>>> straightforward to
>>>>>>> extend mkeficapsule to support multiple images, the capsule header
>>>>>>> has
>>>>>>> an item_offset_list[] array with offsets to each image, today we just
>>>>>>> write 1 but it shouldn't be too much of a challenge to put a loop in
>>>>>>> here and extend the argument parsing.
>>>>>>>
>>>>>>> Given that we a) already use raw capsules and b) they are part of the
>>>>>>> EFI spec, I'm gonna try and save us all some time and just put my
>>>>>>> foot
>>>>>>> down here. A single raw EFI capsule file can already support updating
>>>>>>> multiple images, U-Boot already has all of the machinery for it with
>>>>>>> the
>>>>>>> exception of mkeficapsule but I expect that's something you can
>>>>>>> tackle.
>>>>>>>
>>>>>>> The upside to this is that you will be able to build capsule files
>>>>>>> for
>>>>>>> updating xbl/tz/hyp/aop that can be consumed by U-Boot and edk2!
>>>>>> Thanks for the detailed feedback.
>>>>>>
>>>>>> We agree — we'll drop the FIT capsule approach and move forward with
>>>>>> RAW capsules.
>>>>>>
>>>>>> Here's the plan:
>>>>>>
>>>>>> 1. mkeficapsule tool: Extend Sughosh's multi-payload capsule series
>>>>>> [1] to support generating multi-image capsules from a config
>>>>>>      file, so we can build a single capsule covering all the partitions
>>>>>> we need to update.
>>>>>> 2. U-Boot (Qualcomm): Today the Qualcomm capsule update code only
>>>>>> supports a single firmware image (U-Boot itself) via a
>>>>>>      single-entry fw_images[] array. We'll move to a SoC-specific,
>>>>>> multi- entry fw_images[] array (defined per board, e.g.
>>>>>>      board/qualcomm/<board>/fw_images.c), so a single capsule update
>>>>>> flow can cover multiple firmware components — each with its own
>>>>>>      ESRT entry and FMP image_index — instead of just U-Boot.
>>>>> No need for this, just build fw_images[] on the fly derived from the
>>>>> partition table on the board, with an entry for each partition that
>>>>> can be updated. You just need to add a map from partition label to
>>>>> fw_name string, starting with the xbl/uefi/boot partitions we already
>>>>> handle.
>>>>>
>>>>> The entire point of having logic here was to avoid per-board stuff, if
>>>>> you're thinking "ah I'll do this per-board" you should immediately
>>>>> wonder "but can we do it dynamically instead?".
>>>>>
>>>>> Thanks,
>>>>> Casey
>>>> Hi Casey, Ilias,
>>>>
>>>>     Thanks for the pointer — agreed, building fw_images[] dynamically
>>>> from
>>>> the partition table is the right call, avoids per-target code entirely.
>>> Can I talk to a human instead of an LLM please?
>>>
>>>>     Plan:
>>>>     - Keep a fixed table mapping "partition label → fw_name + a fixed
>>>> image index", this mapping going to be a superset list for all the Boot
>>>> FW images supported in different Qualcomm targets.
>>> This reads vaguely like a rephrasing of what I proposed, not clear if
>>> you really understand it though.
>>>
>>>>        Sample table:
>>>>
>>>> ┌──────────────────┬───────────────┬───────┬────────────────────────┐
>>>>       │ part_base_name         │ fw_name                │ index │ guid
>>>> (fixed)                                │
>>>> ├──────────────────|───────────────|───────-|───────────────────────- |
>>>>       │ xbl                                  │ QCOM_XBL │   1
>>>> │  QCOM_XBL_GUID                  │
>>>>       │ ubootspl                       │ QCOM_UBOOTSPL│   2   │
>>>> QCOM_UBOOTSPL_GUID     │
>>>>       │ uboot                            │ QCOM_UBOOT      │   3
>>>> │  QCOM_UBOOT_GUID            │
>>>> └──────────────────┴───────────────┴───────┴────────────────────────┘
>>>>
>>>>       Target-1 supports xbl and Target-2 supports ubootspl.
>>>>
>>>>     - At boot, scan the partition table against this table. Only
>>>> partitions actually present on that target get an fw_images[]/ESRT entry
>>>> — nothing hardcoded per target.
>>>>
>>>>     - The image index for each partition type stays fixed and published,
>>>> so whoever builds a capsule (mkeficapsule) always knows which index to
>>>> target, regardless of what's discovered at runtime.
>>>>
>>>>     One wrinkle I want to flag: today's SetImage() path assumes
>>>> dfu_alt_num = image_index - 1, i.e. it picks the Nth entry in
>>>> dfu_alt_info purely by
>>>>     position. If a partition from the middle of the table is missing on a
>>>> given target, everything after it would shift by one position and the
>>>> wrong
>>>>     partition would get flashed — silently. Since I'd rather not touch
>>>> that logic in common code, my plan is to keep every fixed index's
>>>> position in
>>>>     dfu_alt_info stable by inserting a placeholder (U-Boot's existing
>>>> virt
>>>> DFU backend, which just no-ops) wherever a partition is absent, so the
>>>> position
>>>>     math stays correct for everything after it. The missing partition
>>>> itself simply won't have an fw_images[]/ESRT entry, so a capsule can't
>>>> target it
>>>>     anyway — it'd get rejected before reaching DFU.
>>> Skipping past this noise... Ilias probably knows better here but yes the
>>> way dfu_alt_num is derived from ImageIndex does impose a limitation here
>>> currently where we need to ensure the indexes always start at 1 and
>>> count up.
>>>
>>> That being said, it's already quite complicated to have to maintain a
>>> database of the indices for each board, and even more complicated when
>>> we have boards that may or may not be using U-Boot SPL (for example).
>>>
>>> Having fixed ImageIndex values for each image would then seem to make
>>> the most sense as we could just use fwu to set dfu_alt_num (or another
>>> platform specific mechanism), however the EFI spec is clear that the
>>> ImageIndex of EFI_FIRMWARE_IMAGE_DESCRIPTOR must be <= DescriptorCount
>>> as returned by fmp->GetImageInfo(), so we would need to also have dummy
>>> entries in the fw_images[] array so it doesn't really solve our problem.
>>>
>>> https://uefi.org/specs/UEFI/2.9_A/23_Firmware_Update_and_Reporting.html
>>>
>>> Currently, other than for setting dfu_alt_num, the only other place
>>> where the image index needs to match is in efi_fmp_find() which was
>>> added by [1] seemingly to prevent an incorrect image index in the
>>> /capsule/ file causing dfu_alt_num to be set wrong resulting in the
>>> wrong partition being flashed. In other words, we should be able to find
>>> a way to safely remove this check.
>>>
>>> But alas, it seems like we are stuck with fmp->SetImage() being called
>>> with the image index from the capsule file per the spec, and it is the
>>> only way to identify the target partition without doing other hacks.
>>>
>>> I'd like to get some feedback from Ilias on this, since adding dummy
>>> entries really doesn't feel like an acceptable approach to me. The only
>>> alternatives I can think of also don't seem great... Either:
>>>
>>> 1. Sidestep the EFI spec by either caching data in the call to
>>> GetImageInfo() or by assuming that the void *image pointer immediately
>>> follows the efi_firmware_management_capsule_image_header (this is true
>>> for us today but would be a fragile assumption to make).
>>> 2. Use the internal image index (looked up via the image name and
>>> type_id) as the index when calling fmp->set_image() - going against the
>>> spec.
>>>
>>> It's not really clear to me what purpose the ImageIndex property serves,
>>> since GetImageInfo() is meant to match on the ImageTypeId anyway, I
>>> assume it relates somehow to the fact that there can be multiple
>>> instances of the firmware management protocol, but in U-Boot we only
>>> have one.
>>>
>>> I think the other way forward would be to use the only included escape
>>> hatch in the UEFI spec with a custom GUID in the capsule header
>>> capsule_guid field which would let us have a custom mechanism which in
>>> our case could just be a soft-fork of the existing spec with minor
>>> changes so we can just remove/ignore the UpdateImageIndex field in the
>>> capsule. Maybe this would be the most correct solution?
>>>
>>> Hopefully Ilias has some time to chime in on this, I'm sure we can find
>>> a way to go about this that doesn't involve exposing dummy data.
>>>
>>> Thanks,
>>> // Casey
>> I feel we are complicating it by trying to go for dynamic fw_images.  
>>
>> Rather than introducing a solution that diverges from the UEFI
>> specification, shall we use a board-specific static fw_images[]
> Well, the solution I proposed at the end very much doesn't diverge from
> the spec, that was kinda the point.
>
>> definition. This approach is simpler, remains spec-compliant, and other
> Simpler for you to implement or simpler to maintain? I think that's
> quite debatable...
>
>> vendors (like NXP, TI) have also implemented static fw_images (in board/
>> nxp, board/ti).
> The decision not to do this for mach-snapdragon was quite intentional
> and was the motivator behind dynamic generation of image GUIDs:
> https://lore.kernel.org/u-boot/20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org/
>
> The image index issue was always bound to come up, and it's absolutely
> something we should be solving and not just sidestepping. We already
> support dynamic fw_images[] anyway and it's already being used by some
> devices, so we need to maintain the existing support regardless.
>
> As I understand it, Qualcomm also intend to support multiple boot media
> (UFS, eMMC, SPI flash) with a single U-Boot binary, so to some extent
> this array must be dynamic. And since at boot time we have all the info
> we need to generate fw_images, keeping a static list per-board is at
> best lazy and at worst will just make things even more complicated when
> we suddenly want to support configurations with/without OP-TEE and
> with/without SPL.
>
> So unless I'm missing something here I think there's a strong case here
> to add support for ignoring the capsule provided image index, but we'll
> see what Ilias has to say when he's back from vacation.

Okay Casey.

Hi Ilias,

Request your input on this.

Regards,

Balaji

>
>> Regards,
>>
>> Balaji
>>
>>> [1]: 7cf06f09cc51 ("capsule: Put a check for image index before the
>>> update")
>>>
>>>>     Let me know if this approach sounds reasonable.
>>>>
>>>> Thanks,
>>>> Balaji
>>>>>> Will send an updated series once the mkeficapsule and qcom capsule
>>>>>> update changes are in shape.
>>>>>>
>>>>>> [1] https://lore.kernel.org/u-boot/20240419065542.1160527-1-
>>>>>> sughosh.ganu@linaro.org/
>>>>>>
>>>>>> Regards,
>>>>>> Balaji
>>>>>>> Kind regards,
