Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED73F606A328
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cPCBYDtQ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GJdE26Do;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EjFHAsXv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB758605C9;
	Fri,  6 Nov 2026 07:37:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6odvHDOtz2iA; Fri,  6 Nov 2026 07:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D36BB60666
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793950644;
	b=WApOqYU4xE0W8/3PXM5DGqa8szycI2jZDkGdi6gUIzxzJbl76kiKyjUCz8fUEJekcCbH
	 XM7e67QiCgnd/EeqpRrciuQsZvbqe3Kuy2Llfq4spP85ueeLmb2TAOisVqRwlMnN7Qtzt
	 Ii0pPTVuvcANSf8jZ6Vz+mqldY7atySjwu6C5EEv2e/vukQGxB9Rg1hXJ51ObeG8589wc
	 0O7hxRD4oGSs1bzNxTzTp4lrudaPl+UPM/8yImgbG1QOrlYu2N7ZV0X0/pWdSlHyypgF7
	 bML5/zLo9wFH/ZXQExStNH9hGQjcRfGPEo8nYbUuUQ60gn+E3hYbh+Qt0Q8V6zSf1dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793950644;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kJuVZk1E8QuKSiK9NV0qkfuS+bZ61nXI+UkhkhM56ck=;
	b=DKvSNl5ZEM31WKXPxYvElDMm9tnGnnWMy+HuGEwp9Ecc0rx80m2VirXIFK854n1PfBdn
	 S+h4bqvBVpmYH6OGj8BRjrG1NXYMaD4drpebukFslhGOzDYIyqZRADznBP9IItl3IKAJF
	 5jYdXmOHyVzGhUlvPpKz7oMB8xsppxMOfyYauQlSKmaDV4EzM6b+zx7rv9SxL622sczCC
	 DL87vOL6grMTP6tR5PwPMObcVr/00CDeCHdZAOLt1cVPZOFMM0+W/CbxVq4RTjerWjlfW
	 LjzEHjaj5VT4PW1DwmNUGyQKnRXPlvq55KaBy2tKgsYc9opZlT2gXZ5ks+O5Ce/XgQw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GJdE26Do;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EjFHAsXv;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793950644;
	bh=kJuVZk1E8QuKSiK9NV0qkfuS+bZ61nXI+UkhkhM56ck=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cPCBYDtQaYILKY4hJTl5bEoaxedM+wDc5ekgqqhHBUr3I+GEb84NfPIiF28AePRjR
	 wKARoWd+A7IhtRinjwKUBP/tg9s0wGaqSjGbfi/2K4dIMCuKxhwFe1ZU2ecSYtwKTk
	 JuUAGAkQaR0VbJhGc9wMUQW/9buBRQCgbwsqeoy/50B8QmD/bHkBhYW8RJm6qWRBFO
	 EvbZXAjSkNZRF0vf2MvNkWgj8QqTeplDECMgXqD3U5q3Vj5TEd7gjv35bdIAafsOi6
	 DH0JC+X8ArETjTF8M3deXT9G6SQGR2bzTZJastWbvyjO10IjsY4hLaf7rdZvsVs89v
	 IB16dxq7QN8VA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D36BB60666;
	Fri,  6 Nov 2026 07:37:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29933235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26DC560666
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4urOeJZ9_Nz for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:37:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3C0A76069B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=GJdE26Do; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EjFHAsXv
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C0A76069B
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:37:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A67RMHv2933606
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 07:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=kJuVZk1E8QuKSiK9NV0qkf
 uS+bZ61nXI+UkhkhM56ck=; b=GJdE26DocsDmD1FMaizAnss44e+prS/sapSGyG
 TlCdYcRyHluBsIitC9TpPn28bukWdgw1IMXR+NbApELOiJdCTcnQmqryVNyM9DRh
 HubfqVuKWjXjZ+d59ePViijpPCBo9aN0gS5/XawWKnjJDc5cLBQc5LT+wtc4jj3u
 ucaMLrmlGtP6KHVAeGERQrPAdSHj3TT8Sz+6VrJSi1wK6ZPuwDIFOIgGRruCZjmI
 /T6eLu9TmnNPG/jfx1aiAy6pGnLK0aG7MMy8fZwklndg15qyP4VrTU7VpCZKkPYW
 dYy8Ypk2ETffX5Fz90nWTsvTsO9I4bZzGS+u4EaEohs59swQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa1np0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 07:37:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso717411eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793950640; x=1794555440;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kJuVZk1E8QuKSiK9NV0qkfuS+bZ61nXI+UkhkhM56ck=;
 b=EjFHAsXvBOSIfZAa90a+suxISZaqAxU+uplh77JCp3GHyQ4ueeSSSYWlUap4iGvWX7
 C0j9VusPlFYwtYltd1UwFd5SJie8XkjztvA7V30E+j7ThKNaPH+9hXfz6xs0eXxuw/ak
 ZIparavwI9os7RS8UMnXr+c0N9r5UfGmjs3FJsOKLWl67xPQxcVUJntm0zX5DzI/pRkl
 5LEaFDKJ/b4kH3Kn6y7CCMsdNpWueebGqrusyh/kH73BJ5gcmBWZsng0BOp36YPe8P3E
 cAUGRxYmaIfUHgNayTGqsIq/BTrb4k4JmasZs76DeS9lq36QCqJe1FbQnwjBhftypnKC
 LGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793950640; x=1794555440;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kJuVZk1E8QuKSiK9NV0qkfuS+bZ61nXI+UkhkhM56ck=;
 b=BmIdOJ5MNXwnTZiOUwvhJQx0+HQryP+IJtgoPLt9HpPH9GfKwEhcx1eywCJOet9OB2
 Q7U5dcYBRtAdvxq52012wuPY8amsfuG5Ls+KGqPMCXTP2qkviKPL+1R6cIflQkcuumjV
 wKg5Oz4RRuZEr3sGHG8Y80D3uzei9qPXHwffqyIcqwa8AJlvbC0oP1Ngt/bMZHuwa6G1
 iY3pEi6YlmzecYsic2Ra0BFEObKbMJBXahckddy/AlKe8BEGvoa4TkfsS/YV+o6Ea/Pr
 pWBFgfOH42IMhAXkIv4V4um0F+U6im0mU7CMuNIE+VsEHs+Zca+Ix34RmkZb/sgu2auk
 3NKA==
X-Forwarded-Encrypted: i=1;
 AL+hErHtpSdf19feanxkTxi1W53uVA1PZNaIbDT/805LFiynaQCDj30yfw25aJ+k5EUUC2ruhYKCyac=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+VGdvy4OIF9aEmsitOJJbZ5lj3EZwHO/6FVO8j96FhxBf3+K6G
 ql+bph3W4HRaSqdLQifbQAtoNGEgN4O2tIxwyzgyuQAbKV6nOwuEVr1g35WPj/E/Z/dlIUYbS93
 zwJP4ieZcseah+nGuEynHqvMPlFpaB6AG/aLoMcdaRSymz1/gOUSHNWj6NWyUEad8bscLOJE=
X-Gm-Gg: AYBFou2pxgGuxECOglakNq3Etr4o/FNstJ9y5dn5GcYatjinouAwJbnnyIyjD1x6qhC
 yOfhN7A/hE3xXhzpfvYa7Qes6fy8dUhXBxYemKGsTcgrggfWcr4DCbOHqfS2DMOM+2JtWw4GUMZ
 Ykkw4GibmR/TBCywG+b4g1+O2Plmb6itev09knBe0cAUh1z+9/FfLrwHQTbVuQDyZJmcI4ZYndX
 Rrb7yVFDROCH67irJmhRU8XuoITUzrNt6aXVpoYI2rb9JR/HRFNtXh0/lHoz4Z2YwQ9rT/3G+3z
 sWir7EheMiiNLxv3XWYPB/0MwEcCa06t9+CA3Q/fxd/XqkAN3LXjU1FtEQAU3oFMwhVzGoZvukq
 z6WqOhWJ6GGoPaecVKWKhvwP8FQ2gcUoBn1sXrHqr2/I4H2OiOn6hjT+rsx2XhlE/wfLUqPUUse
 wMjz+FDkZj6cX+bHeyBMyXC98TXOslOGPqA9Y1SRgeuZ/iismVu3F1zrFCuMpba6t91xcJdFlQ2
 mtuEL0pTnRMfVhS
X-Received: by 2002:a05:693c:8946:20b0:369:7c:bfce with SMTP id
 5a478bee46e88-36f75839375mr2407378eec.14.1793950639247; 
 Thu, 05 Nov 2026 23:37:19 -0800 (PST)
X-Received: by 2002:a05:693c:8946:20b0:369:7c:bfce with SMTP id
 5a478bee46e88-36f75839375mr2407342eec.14.1793950638650; 
 Thu, 05 Nov 2026 23:37:18 -0800 (PST)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa922c6c7sm4753291eec.10.2026.11.05.23.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:37:18 -0800 (PST)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 13:07:14 +0530
Subject: [PATCH] mach-snapdragon: dram: report the sum of the banks as the
 RAM size
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-dram-sum-banks-v1-1-d464040e390b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKmD7WoC/yXMyw5AMBCF4VeRWWuirolXEYtqB0OUdBCJ9N0Vm
 5N8i/PfwOgIGeroBocnMa02QMYR6FHZAQWZYEiTtJQyKYRxahF8LKJTduawqGTRY1VlOYTT5rC
 n6ws27W8+ugn1/lbA+wfk5c3ScgAAAA==
X-Change-ID: 20261105-dram-sum-banks-baea15fe7734
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793950635; l=3041;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=+SMS9XQzphAFowfEHgV6ay4/qL7VJXh2uQ4Ta0GQ+B0=;
 b=C5qJc9CGpOG0xykyRtAxQklCZHg+940wE1i3SikzeN6R/YY7sKEbvh6Q+60VXP/FTKfdsR5ZQ
 kBRymJnH6TbDLpmoq/ZO/I20X2rKTnbSsjUAFqV0xajJdZCw1Ld9TXF
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-GUID: ZxtF1jFeXFX2WTF5FolhulnSFjxwiozD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfXxF06mlSLyaUt
 u/GmPwMrnMnshIesnk9GiwCNRcYZU+FUfNgGRdU5TeLl7TryJb5IP2OOrDacoc48Ig7eLZhD64Z
 Q0Xir4UeNPdwy9nlxtUSvGffqDpdrBMJlgXbGrl8XbRMxLP4D+qrAJQvoTqKiuKvuqQ3zANZ3b+
 PYsMvGCGmRdxRxi3ySPqSvXxePwzFwMq+VLo736tWQl2VKxaBmiSR7vYD3H6Z7CxOXsl+ybwtAy
 QxveS7Ywj79J4e5GBfdHVml02rU9XxLWnghkhMWJiI9gli5/LRxjjYI8rpmT7U7UsF8cKkSrdlu
 ERiaEj2iB0m8NYorV3VlupQ8+N4h+FVgE3KveldRnET/dYwDEnBeZxEmcvO8GLLkROU3TYm1jwc
 AtLVPbutzyEUmwXm37yCaPyXTLXi6WDpxEzs+yz5zKtX7J0tzqlV+9YXU7dVCL8Sk6B9TOry3QF
 TGMG/XVBxFahXhugshA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfXwZlKamSw1zLT
 1k9tvNxuEM8JOx6MMtq0UM9CMXbfF39u+VvOzPs0i5+ZuwhcdItZTRBQc8gYlSXATZ9ZenZb7k4
 kZBOcxaKsir6+yV6DLo+MpybhlBVYaw=
X-Proofpoint-ORIG-GUID: ZxtF1jFeXFX2WTF5FolhulnSFjxwiozD
X-Authority-Analysis: v=2.4 cv=CaKdd7rl c=1 sm=1 tr=0 ts=6aed83b0 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=JvyeQ6WsCxXUoAEz:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2efx4QqU5yiysUFZg9wA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060030
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

qcom_parse_memory() set gd->ram_size to the span from the start of the
first bank to the end of the last one, so that the relocation address
computed in setup_ram_config() lands at the end of the highest bank. With
sparse banks, such as 2 GiB below 4 GiB plus 2 GiB at 32 GiB, the DRAM
line then reports '32 GiB (total 4 GiB)'.

Make gd->ram_size the sum of the bank sizes and provide the relocation
address through board_get_usable_ram_top() instead, taking the end of the
highest bank. Boards with a single bank are unchanged. On boards with
holes between the banks, the values derived from gd->ram_size, such as
bootm_size, now reflect the real amount of RAM.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/dram.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index 732e2bde2d2..af5e19960d9 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -20,6 +20,15 @@ static struct {
 	phys_size_t size;
 } prevbl_ddr_banks[CONFIG_NR_DRAM_BANKS] __section(".data") = { 0 };
 
+/* End of the highest memory bank, U-Boot is relocated to just below it */
+static phys_addr_t qcom_ram_end __section(".data");
+
+/* Override the generic helper, gd->ram_size no longer spans to the highest bank */
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return qcom_ram_end ?: gd->ram_top;
+}
+
 int dram_init(void)
 {
 	/*
@@ -198,6 +207,10 @@ static void qcom_parse_memory_dt(const fdt64_t *fdt, int *banks, phys_addr_t *ra
  * to correctly determine the relocation address for U-Boot is to parse all
  * memory regions and find the highest valid address.
  *
+ * gd->ram_size is set to the sum of the bank sizes, as the banks may be
+ * sparse. The relocation address is provided separately, as the end of the
+ * highest bank, by board_get_usable_ram_top().
+ *
  * We can't use fdtdec_setup_memory_banksize() since it stores the result in
  * gd->bd, which is not yet allocated.
  *
@@ -213,6 +226,7 @@ int qcom_parse_memory(const void *fdt, bool fdt_is_internal)
 {
 	phys_addr_t ram_end = 0;
 	int banks;
+	size_t i;
 
 	qcom_memmap_source = fdt_is_internal ? QCOM_MEMMAP_SOURCE_INTERNAL_FDT
 					     : QCOM_MEMMAP_SOURCE_EXTERNAL_FDT;
@@ -234,7 +248,10 @@ int qcom_parse_memory(const void *fdt, bool fdt_is_internal)
 	qsort(prevbl_ddr_banks, banks, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
 
 	gd->ram_base = prevbl_ddr_banks[0].start;
-	gd->ram_size = ram_end - gd->ram_base;
+	gd->ram_size = 0;
+	for (i = 0; i < ARRAY_SIZE(prevbl_ddr_banks); i++)
+		gd->ram_size += prevbl_ddr_banks[i].size;
+	qcom_ram_end = ram_end;
 
 	return 0;
 }

---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
change-id: 20261105-dram-sum-banks-baea15fe7734

Best regards,
--  
Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>

