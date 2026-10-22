Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0065606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wr4JIw+O;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMdQR4RC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L89vGDnI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 901E060645;
	Thu, 22 Oct 2026 19:04:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wNBTqWlIh3i6; Thu, 22 Oct 2026 19:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AD05A60673
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695896;
	b=MnWP2fOGqo/ZxpnNSS4J9BO82z+eIhYbfwTKhPZ4H+xqmvwydEC8LeVuv3SGcYlCWCLB
	 nJS9Bb3ADKqXdhfcTmcrEcpkTJPS5cU90oMJjVAWJHZU9M1XM2g7GzWR1J7gO4cou+8ZL
	 EU+dCCtxagdDLPlEs8Fw11o10arNuYiJMzaQgWtBE9UK16xNTqysEhI8UAJwCb/oFGZOZ
	 O8cgqjlHxLzkvRhC56z0JpIKL1w0Aoi8esj37cDBYGqGW/SXzCh/DoKrtdDehLMm8llco
	 iDLCiiprDLhICMQqNRTCkEs/JvyCDxGqdHjOvXCcx2E0Z4X4IsXK0scn8zkGkiWv2tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695896;
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
	bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
	b=BDCqjEgA9bJ6HOuKGeMI0zsZ65yMc7pISwrDcQ1+kteU/+5RRmC5PjjE5mLhqKCQ8dF7
	 XJl0XZR/R+M/mP/RVxGhvwyhcEYYveMz07I+9JLUGZvivyAclH4WoCvxQ5YENPQ65RDL5
	 LGQ61ZwlHWJvVap4ZPSH3mvuygo47QazNSgLgh9hP8cSyrBOY9BywfTJB0ArifQnM/E0M
	 o5LhicvlKRZaskIauL3hoqqfzX2nnMogQfsjUz1K+SO/C28LrrMLPPjyJMrFVze5YuSy8
	 Wql1CZ9NM8aDCOhyLfQLl+FAXx2ZB0pXho9NHnh1J5D798I4UKDLh9Yfrcx5PUWHS3g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cMdQR4RC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L89vGDnI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695896;
	bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wr4JIw+O4M5KnJ794oG1QS/tNuP17n4qAzl1TFevX5Q73UB4AcaMyk0yNW5RLW4U5
	 3xl3lHG1cNnI1f0c+K7452rpWxMQtHngoig0u9H5hZNKxK52BGEicyuE5wjVHWJcii
	 fvM3+wPiyy/WuYbQpUoO++n51ouNRY0R2JwmqHWWLcKUTaGPeE51WHducsmXl7pkX9
	 rGaFR2a2IrOuqryVX/JgQUK/j7J3w+H/mFf2Fxd5pbCoyEGd2/KMtRr5c/XQfz9Tdl
	 4MZtIbVlB8L2q5YVwEFCSjQK0VnAyxLeOFFOGJceOrzTHlrEc8TfjSpcXrneO4tU3c
	 2WVNBvavIWyYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD05A60673;
	Thu, 22 Oct 2026 19:04:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CF173C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A40760673
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1VRu4WOarUvj for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FAE360645
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695893;
 b=KzAznr07yKisEVwjp8hagVTtAH+x1D3P3UhRXffKfd3vaQvRohoDqrZ6/yybz0XHnE5e
 zm3tgIrWrQYbdEKqq1Jz6sNvqd2OSYgPRAKOzjGFGjovm2k2NBppuo+e/I5gTgfcIH+QJ
 /lQXkX3ML9PhSlFWBbQXcDLjxyqZ/8nKfyZ/UaTNr7w37U7FHGUsZYNxSLll3JR1N/uno
 FMYri/8SZ7YR5TyOMEogcqO0hGwowqW3qQz6uivzK23I4IBFC2Cim+ZJsSgXjlPnv/0MV
 fiVyqd9m2/pyS9eZn/xG4evM6MPVyvV3s6eciLug/x/ouexCUjfKc3LlH5c6VaG8Pvw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695893;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=LIkGTa4QAL9lG/G7kIi4j+PE4TO/T+b5rWswrC3y7BUIOUQR5n9eLX67d4Ajl6e6X/v6
 wmIm/Q/h04KuSZgwrE2oaNjUFcOHDUELOecTlwoN5v1iaDJipMWGUGrN/NFMz4KiGh2jB
 X7o/UWXREUyCrWmk4EjBXWhhIvfMUPRgo4G2o6kPQOqWihpmqUwvGtrM4i/APVYaTnh1m
 swDnAIDbJendNt6Ud+kzzjHjAzY4cgqS5KhHqY03T41TLDuTQBmoCF0tbDVkgCd5j6B2k
 9EaBdIceDOBKO6Qp7X+fQmnq9IPtPh6OC+NYNpbEno7GWoqEfFDFgRCe+YXDq/OTe2Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cMdQR4RC; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L89vGDnI; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cMdQR4RC; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=L89vGDnI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FAE360645
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:52 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHEUH3741698
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=; b=cMdQR4RCS9KbwSpm
 +JV0NeCSQIzJUwD5VnzhqgqSjS8VfXXJlphQ6XprAdyRMhMw4rbfv5Uy4JnJMqmy
 VFYzXb6GS5o8attT5oR71GTneoqXzbqpIaTl2MU/b3ebnZwXVePEQ9c3WyNlzcH4
 jVrw0MwroMIgejrNXMNtUuQN/73mFBGVM3tWQqod/FkrqDkXGlrtwSiNAHUB1sD8
 hOrgB8ynwoJzhy18HH/ZWs14RYOlCxs3Icyo8K7pgWiRhIhcMGwNnYY59YGA3z0m
 dXs+X/HXFCA3et/ISyqvibfSYLnDMf7MfKwtRbzHBIcdO48FOLrf1mmsDTN/DQJ4
 OUo9gQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms05j0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:04:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso13585885a.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792695891; x=1793300691;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=L89vGDnIC2Xe6CqOT69qLFk2zbOa6q7NNfTe2GGyT7yJCqETb9ZTqlVz3ZJcVoB59N
 tGv7lkuRWVaSkVAg42L9PvGMkdpVFUPC/55cF+vThlKYf5pNNynEY7N5vcamzwe/vucg
 iyYZnvcVqdx2dT1ODe1PckwRs+/+9J9b2x1GUz9+YK2OBzGHtN8bP14lhh/IPyD0fJe5
 zyWEgcayYcSG4uTJxd/jGcn4mkhGJWUL95PoxYAiDjzFQAeqhveQCaR7gi0mup7WWwIs
 wfyxP5uPT/yhZqZlcsB37TFeDgPvxc6TTe37EddhKDd7+QH5glhbtPUhAJmMDHpHIwzz
 HEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695891; x=1793300691;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=klw+scYeRC5bRswOz/vBYHH9AF61OFmddaXD+zCVtSg=;
 b=VYWzjr5PSEDvdomlaMJ/qf8NoEyTys5DNeO0bylggbBHWAoY5UF8AakLO1avHjr6k3
 x3L99y2K4EZSfWGNjJEVq6ve7OEG3ReTipa91cPaRl3jsl7A7RGmmfJAgdRwK0nRN2Ms
 VuRyFpV22zjz1e8ojvyNsbSKAyXvhn51y7oHUzlf7CsyC4ir+qN4ZrapquKKQipesV6U
 bgreYvEUYRu8S02kT0BtcaK9cDXlUBmuK4jcYQwwg23fwRbrPhQjzjmpSL00FI7PPNl4
 DBWaumlupGyK7C5LOuxxib1edXm3YOGrzCxD5FCc3J3G5oDVynBwVQWTCufOR6dlw1OJ
 bLTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwA+bm8SIp1EMsjwQhhdV4PJt4BBaWY+7HuR6K2BJO249L0uq7kWZrxYgKzXDMeMgUuwL5pkzw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLERi7p/7Ln+7vPA4nIk1C3VOgk3oJsUfriuWQDeOGPeSw86MG6
 Ej2h6Fb879bPAWdOkO73sGBXQaxnch6mugt1E3TLYPIiFdsJT3hRd50S65Yz691NjClQpO/DMg7
 dHNyELNQ3/90Ikgk168sxe3VGFLGpEMD7FoJCNd0KC/ctrqK6uYXTg49tHYw6JWqWzjtgNjY=
X-Gm-Gg: AYBFou2v/SOl2F18CWuLaBDn9TUey5MV/vrLydqQpwNhe6mQ3iki0Z8G5hgiJ2FNwoj
 rVmtHOcM2/6iw0g8Zagkff5zsNH1mv20nZymUKeR+Ch0r6hn4NGUODj0SZUJVvGyY01Y8JDx+Vm
 VsUVuPKlNKikSrdf/gSiQ5gBWX8v5L1ySMhUAGJSKVz6A3HYpGedQofO5Jw7E1RfGJM1p44WkkR
 Kta2o4wxUyGhV/SUPEo2e3EvIZO+N8GFjloE/EqqDckYZF5VYPeckrovYDId58fm2xla1nHJoDk
 kLaoOWO5Ybx4ElsurImItbJWuKGx3WNxsb0zIH6cLA74TjzsZxqj8l3IrYDwvjpICuKak25pXMz
 vNnkk9oMJXucoUw0R5WoqLmeNiY2AKI6i6rjChCmFBovV
X-Received: by 2002:a05:620a:4503:b0:93f:3d2e:6bdc with SMTP id
 af79cd13be357-93f6f919d54mr64655585a.16.1792695891254; 
 Thu, 22 Oct 2026 12:04:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4503:b0:93f:3d2e:6bdc with SMTP id
 af79cd13be357-93f6f919d54mr64651285a.16.1792695890848; 
 Thu, 22 Oct 2026 12:04:50 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46a5c8295fsm18914666b.36.2026.10.22.12.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:04:50 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 21:04:42 +0200
Subject: [PATCH v4 1/5] cmd: avb: add read_pvalue_hex/write_pvalue_hex
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-upstream-avb_lock_unlock_b4-v4-1-f4926ca925e7@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfXxnscwOc7O6Az
 54PLLzKjmn2e2FuezL1YIpg+X3P+9eGQqPSGC/mrxESSXK8p+bkSrgZriTPxHPRx2v1x58RaXkv
 2g/nfZlhYW9b6V7nkjXBRhuM1IFF7bWNN0MEMFNqlhwhjDquYCATskUYvXZCVXmaSGIZfuNYqNb
 OBzmljSTZHMpZC8qUNUCZzMPNVBt0ibqgVS0nuXUCpaGf7DIEoUzPkaHBeqghEPpGP3VpzB3rQ5
 +Hs+8Shoz4rasT2bBsH7ly74XyvNq0YsZ4eg62q52XNSPR0uYaTDmEROA7fLszlElQu9ZPoyiVI
 HIqPDlWZnrrx1vuA1fpnbtGfDl1w+TgQjBuHjhHFYzeJci9YnSBSit+7AJC5NKfKDqFhgl4C7lk
 N9NDCKJOjgiarNkPwnTUG+ve4tsaYd/yvOY1iw5R/ydXMm4s+z1q7UgxhmXuqnNCv/1PK05Q/hT
 EA6Ahwa3rTH6ZqHODgA==
X-Proofpoint-GUID: ddvfgVnoDbN2r61zZgE8I07zPa61uC8l
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NSBTYWx0ZWRfX8QDm0lyBDDXY
 225SlQxpIIv2RQ8VymcZNAgjrwK4WmO34OSdJWoZbYTrtXhum6RQ4S2uIKX1JvEbO3TTdOa5shS
 MUEKlq4WSqCMAhl8gtowLKtf8Mgk9eI=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada5e54 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=MoAT0fEG2T6-BM8MC5gA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: ddvfgVnoDbN2r61zZgE8I07zPa61uC8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220075
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

write_pvalue stores its argument as a NUL-terminated string, which cannot
carry binary data such as the 32-byte SHA-256 root key digest consumed by
CONFIG_AVB_ROOT_KEY_TEE (persistent value avb.root_pub_digest). Add
hex-string variants to provision and dump raw persistent values from the
U-Boot shell.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 cmd/avb.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/cmd/avb.c b/cmd/avb.c
index 8a915b65834..3c13d6a2cb2 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -6,6 +6,7 @@
 #include <avb_verify.h>
 #include <command.h>
 #include <env.h>
+#include <hexdump.h>
 #include <image.h>
 #include <malloc.h>
 #include <mmc.h>
@@ -439,6 +440,100 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_FAILURE;
 }
 
+int do_avb_read_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[])
+{
+	const char *name;
+	size_t bytes;
+	size_t bytes_read;
+	size_t i;
+	u8 *buffer;
+	char *endp;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	bytes = dectoul(argv[2], &endp);
+	if (*endp && *endp != '\n')
+		return CMD_RET_USAGE;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	ret = avb_ops->read_persistent_value(avb_ops, name, bytes,
+					     buffer, &bytes_read);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Read %zu bytes, value = ", bytes_read);
+		for (i = 0; i < bytes_read; i++)
+			printf("%02x", buffer[i]);
+		printf("\n");
+		free(buffer);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to read persistent value, err = %d\n", ret);
+
+	free(buffer);
+
+	return CMD_RET_FAILURE;
+}
+
+int do_avb_write_pvalue_hex(struct cmd_tbl *cmdtp, int flag, int argc,
+			    char *const argv[])
+{
+	const char *name;
+	const char *hex;
+	size_t len, bytes;
+	u8 *buffer;
+	int ret;
+
+	if (!avb_ops) {
+		printf("AVB is not initialized, please run 'avb init <id>'\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	name = argv[1];
+	hex = argv[2];
+	len = strlen(hex);
+	if (!len || len % 2) {
+		printf("Value must be an even number of hex digits\n");
+		return CMD_RET_USAGE;
+	}
+	bytes = len / 2;
+
+	buffer = malloc(bytes);
+	if (!buffer)
+		return CMD_RET_FAILURE;
+
+	if (hex2bin(buffer, hex, bytes)) {
+		printf("Value is not a valid hex string\n");
+		free(buffer);
+		return CMD_RET_USAGE;
+	}
+
+	ret = avb_ops->write_persistent_value(avb_ops, name, bytes, buffer);
+	free(buffer);
+	if (ret == AVB_IO_RESULT_OK) {
+		printf("Wrote %zu bytes\n", bytes);
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Failed to write persistent value `%s`, err = %d\n", name, ret);
+
+	return CMD_RET_FAILURE;
+}
+
 static struct cmd_tbl cmd_avb[] = {
 	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
@@ -452,6 +547,8 @@ static struct cmd_tbl cmd_avb[] = {
 #ifdef CONFIG_OPTEE_TA_AVB
 	U_BOOT_CMD_MKENT(read_pvalue, 3, 0, do_avb_read_pvalue, "", ""),
 	U_BOOT_CMD_MKENT(write_pvalue, 3, 0, do_avb_write_pvalue, "", ""),
+	U_BOOT_CMD_MKENT(read_pvalue_hex, 3, 0, do_avb_read_pvalue_hex, "", ""),
+	U_BOOT_CMD_MKENT(write_pvalue_hex, 3, 0, do_avb_write_pvalue_hex, "", ""),
 #endif
 };
 
@@ -491,6 +588,10 @@ U_BOOT_CMD(
 #ifdef CONFIG_OPTEE_TA_AVB
 	"avb read_pvalue <name> <bytes> - read a persistent value <name>\n"
 	"avb write_pvalue <name> <value> - write a persistent value <name>\n"
+	"avb read_pvalue_hex <name> <bytes> - read a persistent value <name>\n"
+	"    and print it as hex\n"
+	"avb write_pvalue_hex <name> <hex> - write the bytes given as a hex\n"
+	"    string to persistent value <name>\n"
 #endif
 	"avb verify [slot_suffix] - run verification process using hash data\n"
 	"    from vbmeta structure\n"

-- 
2.53.0

