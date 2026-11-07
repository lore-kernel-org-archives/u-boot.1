Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AE606A97F
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kQYyl3w2;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=cisTfZw4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C169460640;
	Sat,  7 Nov 2026 15:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpaIYh8KUj7e; Sat,  7 Nov 2026 15:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F28CE60681
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794066609;
	b=lXyHQD3ndao3mOSl8dkdxxTkcgUQpJzIJ89oImqGnbFtj7lSyjgGw6i9UxVA0QHCR36j
	 /oIkI+zpV9CwNBK5G8PPbKZ1q66St9gb38PzBMtwN5Hp2kJrcFBlGE4ByANg3ERQhJDlt
	 eGjL+ebjesmX+cghB5NVOwjgMpEpL1A4PDSQCSyeheH8AK/jxW4KOJY+5yUn+y4fKary7
	 iFhlkylyuauLO6udOAshalX2piXhdZ569S0RoA2lrcNMKZz35oG3Z4fWoell+vatERA7z
	 oZxNWU1vdk5ZgvWg7OaP7NQi8khtMMjQ20BEy0cLkvJ/aJupz3yFpQIV7SZ65Wf65rw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794066609;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:CC:Date:Message-ID:In-Reply-To:References:
	 User-Agent:Subject:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GJwYJZsFQmn67xkJLcVBbMPMwmb0F7D6IzQNdejtOTw=;
	b=j+rQfuSzYvYb4CMtL/GNZ7jXcyT9HplCxx8efpu5fFscrMLmiPB8LznJebnftJfwzQwX
	 79EO7LEsbe2oa/q5E7s8DkYjy/gMziBoWRuBwjeSHmv79PKRVaYLdqfCXMYWQT6hF7+/H
	 rf/RMMqv8xmca3iVHDvMnKjl4irtxSeqlSaDrYnPR562TwZZEgb53idp/8Goz0+hE/PDx
	 U2M5JZmoNO3cIJRHU/ouOWtWrkPHzGEF87bJjSv1CBR/5sBofV2lLWrwUv5pXPqeCAalT
	 SIU75Flb898rp3nuTMc59ziYQO8T3lpiR6+yiRXXtBpzhW7GQSTh62/z+QFkfFbmOaQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=cisTfZw4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794066609;
	bh=GJwYJZsFQmn67xkJLcVBbMPMwmb0F7D6IzQNdejtOTw=;
	h=From:To:CC:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQYyl3w2iJA2GPIKuU5SFGz80jUwgJ3BiOXj28QH71rJj0lJhZ1A3pU1iaXeHW9dm
	 v+rx7KXkwmhOEhsOTEgo24f2jaeHtfAEyJOUTT+8USrH81eKy56jbIn5QjSR23C3tN
	 ge6gVZRNxFZ4IwTxYFXdEAd6VBLa6jHLgDCUrxhr9zwgXfVM6yczJBkg0CPSpAvcxQ
	 i0N1hFVL6lq7nj5h+MMsBKjThtLpkRxzYUOnzMPX53gEhNpuEyVx9TzqvFvgWDl9Wx
	 vYGXTUsyW/H61pH1o9Ai9tnXUwYThpBSUuKDajkSlpB3Zt/ihlhOCPPegiptHUCJuc
	 5IUG+KZWJFCgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F28CE60681;
	Sat,  7 Nov 2026 15:50:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 38C7634D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29E8B60681
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5UWnh8nuQ9u9 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 15:50:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB46E60640
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:e0c:1:1599::15"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:e0c:1:1599::15;
 helo=smtp6-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr
 header.a=rsa-sha256 header.s=smtp-20201208 header.b=cisTfZw4
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB46E60640
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 15:50:05 +0000 (UTC)
Received: from [10.110.216.140] (unknown [78.240.134.4])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id BD08B780331;
 Sat,  7 Nov 2026 16:49:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1794066603;
 bh=3bqPRSWHop2ZFcNZkHG94KdKhd/+TygtNF/PM0V4pnM=;
 h=From:To:CC:Date:In-Reply-To:References:Subject:From;
 b=cisTfZw4OwHhJuYofpG9TmpZRlzxT4wkMuu5+fQGWHf+nxNyJxuK2PQ4U6IMrSOBc
 49Fp+FKkERExa0DoSLm6mCDvjZy4zSIgSuO8kmWfHpwxhuIYUv72sg1ZO2NKRBgkP+
 YGPmcdbC59d0WFX6WI8n5mnWHJcr4dE/nj/7Se0Qm5//apgx+V9d12hqrzKYwyuX+l
 8IIMySWcwOMsDD1QLmSqobCVuoLuj1yAnGgjHW2FDAdshNfUSuyogUjRP/s5OTuZnB
 76xPgHMiN4/b6ID1OEhsDzDl5DOc0qx+uXzju4UqU0kEQ1A0g1kFhcYgNMZ08Dxceo
 gnddYwqn+a23g==
From: Vincent Jardin <vjardin@free.fr>
To: <christian.koever-draxl@student.uibk.ac.at>,
 <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <patrice.chotard@foss.st.com>,
 <patrick.delaunay@foss.st.com>, <uboot-stm32@st-md-mailman.stormreply.com>,
 =?UTF-8?B?Q2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhs?= <ckoever@outlook.de>
Date: Sat, 07 Nov 2026 16:49:54 +0100
Message-ID: <1a1b6b3b8d0.2728.ffe91ee9dc07baa0c1c4561a0e181c1b@free.fr>
In-Reply-To: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
User-Agent: AquaMail/2.8.1 (build: 200801029)
Subject: Re: [RFC PATCH 00/10] Add STM32L4R5 / NUCLEO-L4R5ZI support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="1a1b6b3bb9d152b27289e623f"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--1a1b6b3bb9d152b27289e623f
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi,

Why adding uboot for such MCU ? I am concerned about the technology debts 
and the related maintenance without use cases.

Thank you,

--1a1b6b3bb9d152b27289e623f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">
<html>
<body>
<div dir=3D"auto">Hi,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Wh=
y adding uboot for such MCU ? I am concerned about the technology debts and=
 the related maintenance without use cases.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Thank you,&nbsp;</div></body>
</html>

--1a1b6b3bb9d152b27289e623f--

