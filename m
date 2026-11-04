Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325B606A32C
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YYRoHDvp;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UFdenSLh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B/zs2Y55
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B414240219;
	Wed,  4 Nov 2026 16:24:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2i4LQHyb3gu; Wed,  4 Nov 2026 16:24:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EFF944064B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793809491;
	b=li0xXBmpKN7Lye3yL5hE27RWGp7ou9wTsYZqS8+4SoWK1qI7007W2QuXfS26m9IIAiA5
	 WLEI4fSz0TVWpdybQEG+OdvmmShBnyKQvhGBx3GVRdGHltAZ3am/KNRdI364tEFmtWejb
	 sK5JFQ+olVs7+0Gf6HAkAn3LVjb7oYMI8hZsc6mKGjgc8ao4wJv2HA7L/mOosJ2aUNu9A
	 JWfaEHvc0NO6UPssTB8om5IJDY/kA1QGuzZmeF27QKhZ4XxYAuNcwDA7OTLvmXCnz85+v
	 Um/bn1by4l8sQoyDcUsKs970BPkZlY3+TJsMhgqYQCPl64AtyCElPIHYm+SS2gVvpuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793809491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5QTnL6SebjWX9PscgyZRbux1aZ9m79xZXHaUZT0SPT4=;
	b=NUuQcQUxS+mY6lPmFs9gZmHKgP/bGzSf6ilM2IY1g2AM8vD0RkHAYriixYtlTBjpej/P
	 ctuE0T5RnfRDGXdTBzUp8shvZbZRdGP/odq77wvTcx5eLt78Egw3HTjrOXDuMogndeyrF
	 RCWQsIYLv1lurhurwfocfAHmGKxSTr6ewggPqGyZKdhUISljIe4Rtjy7tsf0vGtF04BT+
	 DlLPRysaQ7Hxi4L3rj4HZYz0erhQrIGPmvUce6sw6hCP1oVZmTZro+YZx6hu8jK9l26Qw
	 Lg1zMQhJf0Ip/B6F+KkapCWvYUMhA05deESzPQUcU9sF5+0vAAm2ydexcTGHSl/VM4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UFdenSLh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="B/zs2Y55";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793809491;
	bh=5QTnL6SebjWX9PscgyZRbux1aZ9m79xZXHaUZT0SPT4=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YYRoHDvpjnGrk04ZOq3P1FL3pXJAXbGwGnsfq1Yr0Zd9vOjUQc4LsDgLx/9IILMtj
	 gSTW/GsDUgv5HjjRzJcMh4MbAFWcuWFoeAdJtrreWETIhrf++PwaXtJF6Gt6yHVJPW
	 NF5S4swJqLHBzmRfhwSg1NMV0loZBhIBsIkYEEec/YNVV6EqgzffGR0bc8Tp7UGWrh
	 VTytam1Wg39pY3q4ss5tdh0FcV38oDZiF73bb04udPVHtAlV+QFbhN3TRSyphd4oGk
	 pxNX56cSuykl/MB6fse/pjUQ4fSs51wxYG9w0cXJh6td8ZfIz4wew5ivXYQe5v5T/B
	 rvry6ep+IuGdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFF944064B;
	Wed,  4 Nov 2026 16:24:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AC9EA10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BB5C4064B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kp1DS8Ct-u5V for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9779140219
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793809489;
 b=BeDXcG9fawcgrnSe9PQYPrFlvwATVuaUnGXThNzD7LxHn7DNovQVaQYuX5wayESmzPxm
 ksC7XclIPOiFQwsWw3ybT5VrckYeOBEikn+Y5Ig9w1xvORvxA0t2vWEGOD3p98+BxUKAJ
 N3KzW3liN5LgxydhADBfqQw/EmWGMxCeeuWw610Vhqo7IVzRlFSOcyQEh/rZVpR8aalMQ
 8QlW607zateoUqjqv24y/mED00FQodW1/Vw+5PiC+xH/+ydYhCvcO9plRxNDGu9Q4SM6X
 CUJDY/D9k3Gt/H89a5WzDAaK2cOnDsyae+kEPTiem5zMsp9WRU6OqV48c2Kyxp/wy0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793809489;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5QTnL6SebjWX9PscgyZRbux1aZ9m79xZXHaUZT0SPT4=;
 b=pG9toaD23e8Z+yStrFZIHFNIAFrCmiMXXsHDdGCUDhiHkBaro/bs0oxmRvIUd0xuBx64
 yOgC/C/j1jOv6bHxtdW6wAc913c/fAMKStSQQcYtlSxqPLXSlc2Z6yWRpygrGfcrzFQxB
 Piaf1cx0JJkiR1YkFbAFzGA4rBnJYE+3MgwuntG8QmoaJnNJQRwQwYZIWowk0vgUmnqKY
 H+bu/CJiZ89ILA8x/7QAPIujcLD3UkLU0t0gMkRb6I87qZ024eSId4DfNkXHVQWJpIMvR
 u8JBv3QiitI69XAeHUzu69qzMRHS1m+nR3n4vfckxEGNFlylfgoZzQQSTFhjEPMIhQQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UFdenSLh; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="B/zs2Y55"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=UFdenSLh; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=B/zs2Y55
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9779140219
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:24:49 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiwnQ2210824
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5QTnL6SebjWX9PscgyZRbux1aZ9m79xZXHa
 UZT0SPT4=; b=UFdenSLh3yW9x4IVtjud6ic7nV0x8FXNgaIXLu0BZhrzKWWJPEn
 YG+hq+6awF52gNYD5vpY4m5UsBYNOAx9IH3K6svTZl2pJ4BzDRwdN8zxLUBgRo8Z
 7nWZwjjfycr4cM+sLiXzmFbCLUQBrsf3XRfQR0cJD3ERYOeKSj2jdPABOc1fnSG5
 eb2gL+UH0J2K2jUzny16ePgstYZvmuHHvelf6WJc3cvbcsnLuR75/O0fSDvSpI6p
 O4TI6rW6xvB0hxOC7D6aFF0JANRTJtjaHiq5XAgF6B+oFSs5q+Gwdo+vczEry50D
 NHRSTaosdQkIluco0EG8bhFvtnQXJOnyYYA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdrg7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:24:48 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso1590198eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793809488; x=1794414288;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5QTnL6SebjWX9PscgyZRbux1aZ9m79xZXHaUZT0SPT4=;
 b=B/zs2Y55SjStaeiwpCNoBZsXX0EUlQe+9SMv1xJ2X+uvkrAcdtS3NGYOoJ/m/uCNix
 9xxsULRegzeXjFD/2Y1ATVia7Y+80SmtAUy1h6RUan8uKR0MJ3Q6BGFgmv//Vd8U3ZzJ
 /0o2iRSzwjxlHLVLySnIisHNVRQVFeNyR4gjTeTCNx8P+2oFG+2DWkJfk4SV7gJzP39B
 CUIaKrTc08kv9Irvs6mFC8TlIZS+HZUl4fvMwv6aLpaChqnKJOTjUKT8M68yYAnobip1
 9fzkaG+1kXAmRwaN98JkJCCYC4T8NqqGKiJqCwNb5wUys4rvCT0aSnW91B6/hEsJ0KRn
 NbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809488; x=1794414288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5QTnL6SebjWX9PscgyZRbux1aZ9m79xZXHaUZT0SPT4=;
 b=NW7g6PDOFYnIDM151dSIIwFUP6ezE+esy/bu2KG+hYaQFmeC93f9BO3Jx62JP1LrUD
 r4O8Z7lgqm6Jmy1Cn9yTL6+xLTUd/5+9z6dJupLxjudOuTfMeurQypgJQ/x+VxebJ6/Z
 l+9z/gb8B0FvMHxFlaEzUyH358bRjQEaOVLVs1Zhr3aip30Ly1uhoNn73l1N3ysUF8e6
 C3+CqHUlGPY6xDAZruKthdJWtyindrRjVNy8i6PhV3X0G9E3fJKO4KPdzoBOZKw0s50F
 oKzfsIWT5/3Uz/gKL/KKZs5LXE6zg10WiAZ+9YwOhErEolYoBA6fYUP6sCkOWVNzcqKL
 npQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+I2O2/O6Vo3IBE3zlMjRI12Yi7VzpaWb41yLe0ezR28/d5pWpwGwrhslTmaOfanMTTwsguKo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/bByrxQhQdzuxWx11HDkvkmlsBjRPY3zOygAV5+tyU01Zj5xZ1
 8Ap6LXyr80GzN5Rf9TrG04yTVBOComnc/boFX3W4tyTBDZjofEVjLqHkfM5FAD6xsHGzaku39cH
 ZwzeaoU94B+WH5jgqN0+TV0Lpa2tYcIqNSiVnvbGH7+HvRmPm7jUe83vtvHG9B11e8f6Vk1Y=
X-Gm-Gg: AYBFou0C77yMQvOrPbP0rEm2jDvCMoTa71WRmKU2E8WOZa56GMxj9FTLnPMxr4TGikI
 ETyiSVpaJjfSf6k+WE8mzCIzNKj8LBOETayXQMvxS5s/r4CqQCbOcjVjBqdkhEgW9kB0Crynx4Z
 9Kys0YP7obGXWjxA+Ku4qQ9TOUHvX5NRs65eInyamReErdbXIEY4HyYCRfKizRt2yiJi3A3qrD9
 wSApd719/c5X65sn923G3kkHwMxBCJAUXDSJnqSVFBj9CvHZOS/PC29U64ohCmTLAYGgPNp7Nx1
 QYUgw5olv0PxeeMFCDFXtvG6BXWF2M6jYpKJPUBETRY0/ehnj9R/rP/jTgGBzl6mjN0ASEtweRN
 U/me4y6hq86QP6lZ3wpYQeuBfpCzRKWCAMg3KX5ndZfkQjUSLwsV28zgYQBdHim8eTK+Pu4qTNQ
 z+W9smjSRTP9KsItWbkFbIwMib1Setktb6dJZXmvqplEaoWf2DoJOQWPpy1E7xDC8Z
X-Received: by 2002:a05:7300:5786:b0:36c:3b8a:8090 with SMTP id
 5a478bee46e88-36c3b8a842amr10217335eec.2.1793809487713; 
 Wed, 04 Nov 2026 08:24:47 -0800 (PST)
X-Received: by 2002:a05:7300:5786:b0:36c:3b8a:8090 with SMTP id
 5a478bee46e88-36c3b8a842amr10217289eec.2.1793809486949; 
 Wed, 04 Nov 2026 08:24:46 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36dd85a5464sm196834eec.4.2026.11.04.08.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:24:46 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: neil.armstrong@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1] pci: pcie_dw_qcom: fix BDF-to-SID table never getting
 programmed
Date: Wed,  4 Nov 2026 21:54:19 +0530
Message-ID: <20261104162419.1243471-1-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX675Qfs/Ua5/r
 aXGo254EWZApTaLy8c5ZN5mtSmw12VMd9/xIlOOHt/tdgApiVZbFQQ4qEt6gBE3uW7rnVU+xd50
 FhC/jYK4dL/tNxdvMzE0PyRavZmjmds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX2XYhC26noto0
 Msj4I+9735VYocReIQOYWQBd4WnMcJv8yEhMRIsg7JF+OAOLIrJSWYK/5lgq1ae36Z9E9DWiqSi
 p05Ir9rPTRn290uEQoURuGLZ29T5rKz3KKfC++XA/Il708ra5/LZ1tnb3aLnPfrW2Wa20bVVJ5K
 kyjD41+ftehPS0X8SqCFoLPyPJv2jRXXHWV2OXeQO3EI9VI0pyDHzAGNaQTmv+IY/IO1N5a6+FI
 4hzLLPPSPRW1UUwDtrDsOKecjR5l43otEhSDR478wlOGHdibih8gcggGTvi9BY3Dcie+Z0zrvHh
 74oSXK1aNzAlyi7B82Jm6cHmV5x/t64mKoTPe+KNiIjGyhYRxV7K7wcD01f3VkWr63dForabYIc
 5p+J9SP5qThn+Q3MI8U3U5TONsk1lqWUPMzbvbFw+eF2fOQqd7PF+xmd1ngsfZfkBhlxzxOiTNy
 bt0MTWKiTxjFZai3vHw==
X-Proofpoint-ORIG-GUID: PqDFEsC8on2D4-tY8EAjkIpiH-GeuFVj
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb5c50 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qDKUL4T9919JXXYbphEA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: PqDFEsC8on2D4-tY8EAjkIpiH-GeuFVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040065
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

qcom_pcie_probe() does not set priv->ops, so the of_match table's
per-SoC config_sid() callback is not invoked by qcom_pcie_init_port().
As a result, the RC's BDF-to-SID table remains unprogrammed and every
endpoint's DMA is tagged with SID 0 instead of the SID from its own
iommu-map entry, causing intermittent DMA failures on SMMU configs
that fault unmatched streams (USFCFG=1).

Set priv->ops from the of_match .data via dev_get_driver_data(), as
the qcom_pcie_ids[] table already intends.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/pci/pcie_dw_qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie_dw_qcom.c b/drivers/pci/pcie_dw_qcom.c
index ce6b4d97d1d..dd69d8b99da 100644
--- a/drivers/pci/pcie_dw_qcom.c
+++ b/drivers/pci/pcie_dw_qcom.c
@@ -489,6 +489,9 @@ static int qcom_pcie_probe(struct udevice *dev)
 	priv->dw.first_busno = dev_seq(dev);
 	priv->dw.dev = dev;
 
+	/* Wire up the per-SoC ops so qcom_pcie_init_port() can call config_sid() */
+	priv->ops = (struct qcom_pcie_ops *)dev_get_driver_data(dev);
+
 	ret = qcom_pcie_parse_dt(dev);
 	if (ret)
 		return ret;

base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
-- 
Best regards
Sumit Singh Dhami

