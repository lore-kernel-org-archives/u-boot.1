Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7F606D561
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=boa29L6k;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tla0tyi9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kdJh4Rfz
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D15481106;
	Tue, 20 Oct 2026 16:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALkVBnuTwzHG; Tue, 20 Oct 2026 16:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C921881111
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792514869;
	b=EXohHZztegMNKljDHMj0veC34B57/c7SkGUGygnyNICiSDoVWEkmUFPUcBfWRkIHgYe+
	 bBiqQC/pf3fMz1Kpm3jEHivHLOvFUxRQ77r4iWJl+N/CbCs/nol5dj8cAMJ+3xZkdD38f
	 q/xxc5HPaNtAifX+FGCYwnXeOcPRkLl2wxv0nfZ2dAxt03ZFOylJZ3mr59WSgYn21Je2+
	 oqOpFo4cofIww7vgZQ/DbM/woitHNpYo572bWui1wsMiBRlF8qWRIXLU/ZApvxSnlGpD3
	 3aDhmqgu6UKYH8OqBC8Mwo+UZ6xYIkh+SV1L5TlIBDqyo2FKVIIgWYD8RwV4Q3HqTCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792514869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=brp/jEPA+EDDk4/P8I1sU96SVEw9coMYZdSOIpJtBao=;
	b=mmTk7Mb4VZulPfinfoHJSMHI9BPGHrVbIlTf7vrXRoe3ntkVxZnSqUJuCM6VlJ7f60zG
	 7241ruLDdhwGiDplnfmk0mKkXatVNk62nRK40c/FGEptB+MrHDj6d7gsJkxKosxL4lLNg
	 cw90RNuiGTW/CzDbtcRvBgePJLKerUdRvwSD0VqjFNBFYl7cUSOmdIqtjvq+EdvCf+WVD
	 UfNKsmfioTagzjlIRxc/Q5Y6AHdVT19UJmz93I1AT3rEm2mX9ZpbBFsXyphwEAhXjX4xO
	 DFSdrWkeXk3yWO+qbte7Ji/I3wJm7/Uo5ao71aP9oazTEZ84csceSTzscLCGyI6Btdg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792514868;
	bh=brp/jEPA+EDDk4/P8I1sU96SVEw9coMYZdSOIpJtBao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=boa29L6kNbpQWHXzukA9yNUF9+dE8p8EgrRlvaBzVvIcBkN2RRZNmUcV4rLrenq02
	 uNhHciX+7TGDkrnb6PxnpZP+A0pjxQgr1btlA7tONaIWPRYpd3u91+HC5PxjdQt+UQ
	 Ximg0jMHcrwMpZ0OGG4qYGFOjm6wrpAwjHoUNlT8mmmuAoC/W1kqyoVEPQ6f+noBOy
	 XhBRGbe+g6RI72kZiXPV3kCndpsTVLKrbSAjDP8LZPGZb+hrXkJJ5acYCxUqXzo4p6
	 zgxvSa6VmPnHR0RfsxfbKSgf5wbyKxVtsl9MySZDBANPH4iF4iSG3Iy6xo5OINJWxb
	 Ip8ZhKX5o/k7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C921881111;
	Tue, 20 Oct 2026 16:47:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A302C1E9
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 88CD540918
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAY5PYgtCoZH for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 16:47:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA530408FF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792514867;
 b=K4XRTcouNoFAeGHujvn1Qn3zRHGxOvdApb9VatiQo6f+VuQfInDOo0g7gjgBDLA4s0dy
 brbE8+OFNyYfWDRsJJWoTstccndGPY9zCwW2VNwoHVsAV7wifTe/0h9Czr6g+S2HzYPLb
 2BST7QjmOmuX71mets+8gPhDDfbBJMUQ6/YeqSVHdXHYLhYCjDJRH0Chp24LUnRHq8fdb
 0Fr/WHv4l5mWKLQuuYzO80c7Eq+fGKcJeIFRt5Dwil/wM3oRolrynk89CW3EVPxEjCf5r
 /bmVhM3YNBPRdZkj64QD7ggwNhLxgDv3KJf9CzQxfAm/or8JdQweS3WO+bJt+L4GIJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792514867;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=brp/jEPA+EDDk4/P8I1sU96SVEw9coMYZdSOIpJtBao=;
 b=mW2LataFCPlBe7hEDLhe6Cx4Wg7/MPXvvwpTKvUuXVIMAmL68GZWariCFQD+tX2OqGVv
 lCjxaH9fNuwkFGALlFO1N3AXvfEpX7u1kR3sods8t+AxEHylAW7AxPJenhiRZqb0vpv6+
 X8iZbYffY3Me+pt2apm3gkqPgCxZA5TYuNU2tBNAHBvMHeJv+jxSyJxsRNNx9RLxqo0GW
 C7U3zMyTdmjYhuSV88+YTELzQdq692nrpCf9i/yJdh6FNv0IQUfTU2kJfTLSyq4A8phLt
 a0Wupl0V481tLs4ptGODvT1yR0qB0pQiVqvo3bQ/pQWO3hBTQV4WZO/cWMQx8+Tyl0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Tla0tyi9; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kdJh4Rfz; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tla0tyi9; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kdJh4Rfz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA530408FF
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:46 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KDACme1429965
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 brp/jEPA+EDDk4/P8I1sU96SVEw9coMYZdSOIpJtBao=; b=Tla0tyi98mBu5WSa
 13G1Gww/f1QgfiWqhbqwcMH8TugHeEY7LuWkHuTkfihWsxRyT1LiYSBk1tqNhdqu
 M59sZz8ZSq+CHqnO4Yyn/0MVSNY4dPvoM4Yf3Ee0pt5A8GTOEhqgVs64EPtEAfsT
 DVfUKo4Cshtt5Gu5xnYeK6iUZkN4nQlqcvIYGzeQJ2YjFPKOkFlGMDovgmIZhtIm
 iJrs7tCQx8KuerLwjujcuBkM/lKf0/CuqjyCk4JmG5+xP0r3EgQV9AASdoa5/rA0
 BF8+jvVJ37FI5y2bzIJgCdpb6LE5HT6o6Po4XbivvIx95FKDRgoeR/3MnT+rBnFn
 9WTO4w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qbfda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 16:47:44 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36637676140so1447841eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792514864; x=1793119664;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=brp/jEPA+EDDk4/P8I1sU96SVEw9coMYZdSOIpJtBao=;
 b=kdJh4Rfz106d/5Soqam9QWQkGdirtyl/gd1oIyrC97VKUjDNvwP7bYLw6B7aK7+sMP
 4m7lGBLrB9roG7biiUQqYVGq4+5PdP3w8cEK/r6ODniMdRCRuPKBcg6S14M99fr7Uncg
 rYhqpufiwtvTE9tObUFdVi43IRwevXq0YOb9J+fyZyII86Gse4Dk280zVHsTqQvFvSnM
 eGBS44b2jZwoclKRHdCna4LwKnPiQyIBXY35f05fvd+j6BtDzdBCqAmi7tq19oCatxtK
 BMqVjxMlf7Tkw2So+s5or1Co2ejR0xoHZtTZFVH+n+5FwVk/ztmtjuWWKvU8xrbrwp6r
 qLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792514864; x=1793119664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=brp/jEPA+EDDk4/P8I1sU96SVEw9coMYZdSOIpJtBao=;
 b=UpX5vzJDs/a1jdpBjzjmjgGxz/eTHJM+YI2ywdoBLwtDUSBrOps4u4Tbh/TKiFV65R
 gb1UAFFXis5iciwbdk0fVf/UyXz6Pb27TNrgC4+MSghg6/sgW1o1/nci7YN4d7lI7W/M
 cvIPZ0RIsMPefR17nhyCf7q3Con4tZbZVSt3afUeOX7psLdsrY5rDyKiecRUc9zLaNzx
 kGq2Uj9Tqmf+xExGrkS2KCj+mcQC2/QJ00YEk2zFp84UqDS8xQGnED+7OfATh/zXuUhS
 mBzv32T3aannZJ2QHsSAeUlAOrPQGelGt5lWLCpgrVUloUWc5COW3pUQ2kqdVK+1C89E
 bSJQ==
X-Gm-Message-State: AFq9FYJwOvBWjzRP4IHf/wvqoFzjFYtRPPJ1cpJrhiUwlzNXtwl9ow1T
 0zoMAe71giUemI+5sxOhVUG5Ekg732+aZWTCOre2H9Pypmui/xYM5+x6/QDiEHSGvymnq6kHFJ4
 VdFpA07t7FTrCObnQV0g4yiFgt2D0sjCANfeHO2g1kyMuljNhBoQr3vHqi19L0FAiGtbOoEI=
X-Gm-Gg: AYBFou2ziV0zHdQEuwvPM3r+imG2KXXH/UAyrE9WVqipptQOUDk11dsmPqQ3JxFmpsj
 kApVsgy9xh5Ms4/GS7tyzT0WslKjbz/cGlaZLrL6C2p7vGUnGO2zS+48mQ1dGioJ90UUh8TTHDX
 KkuvBXC6j5F6K8BNh4UdGoCiftEi67TkUGBO3pjgj1rb4xgNwKOqg79MBPRhJZ33lI4yl5XKXPp
 hGKH0F1X5IdcPaE4zEM2gps+ZEgxk4C7J5Cu62Yw6wDL8vli/9Ltnog0PxORRDVc8bC/5zAWCtE
 kFkbliucOk+wcuSfEyiB6a+BkgSLet3UMWEUxFQNmW6YiWqgWhbjn1IBbXcKjL8Iv2Wjnk80aa0
 LsDz3uIgbIaHBqozkfb1d8ydfZSE6cb+bU6569qikICKg9vk1dHM2RBR4GvT+TLN2Qgp71AoWqA
 0wjVqJIhCvgJc/H7qcAAioMbWPuOA=
X-Received: by 2002:a05:693c:88d0:20b0:35e:f4ac:5f8e with SMTP id
 5a478bee46e88-3619b8fc307mr14185500eec.0.1792514863442; 
 Tue, 20 Oct 2026 09:47:43 -0700 (PDT)
X-Received: by 2002:a05:693c:88d0:20b0:35e:f4ac:5f8e with SMTP id
 5a478bee46e88-3619b8fc307mr14185465eec.0.1792514862744; 
 Tue, 20 Oct 2026 09:47:42 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36632d8b273sm6318507eec.15.2026.10.20.09.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 09:47:42 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 22:16:27 +0530
Subject: [PATCH v2 8/8] doc: usage: reset: document device-tree-driven
 reset modes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-reset-edl-rebootmode-v2-8-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Vincent Jardin <vjardin@free.fr>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792514792; l=3260;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Okcw3V8VLtN+WYo04CeK2kdBcI2LrYngJiqNfX3gAJM=;
 b=l8ZB6dO7JjVyWBquq7l+gCWuba1o9Y4ysaCLmsEm4iuBcS2HLiYDzKYKnQoWAh3/Jq+6sM3ww
 EbQ9+cx+XNLBJzprtnXbXiwoSv/wrf4/oxEu/PFca3UP6sm4M8C3gKd
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: uVz_2zd-uKTZwEr_Q944vyUdtJ_NjG91
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfX4SxN/qsofPQn
 FX2fAFVobkCr7GBlVpaVLoGjngBiBv/wUg9RbwGvXEmcH27XRg4zpD430KdndjYrdO0IJy/4W57
 U9jTgukB1/i6DhpTniANZn67bfNEFZExpLiR9WCdf9LHHaMHh49KrsinTVirDmnLyI/CmprRFBF
 sjFyyGv+eg+kSaQ+rj/A9Jzp2FRH2uiYLcBPJq9wYomzmiJTSN8wF8TSYqfLxE0rKsNHHFjziMN
 /uMg+wFxgC7SykBIHUZJdlcr0SkodKDsR6NY1HiG51V9HXWhI6rwLOuUx2DIB9BsM9PrGUS5pGs
 OQ1+DOe02oRf3uP+3E9Ow4XsqCS+rwNRdAZqZsvUa0CP/Yz1xrjtNsR6U2Y4Xb2M1wSr1161u2M
 j0eXstowC9LztpI/0L8mRn288p2R/m47ZQX+0lSoJCy8zsZHz3TH7nUEoN+3/qth9cTzuOR/yW5
 c0ccoB4dtPTqkSD4lLQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA2NiBTYWx0ZWRfXwEaWqix9A8Hn
 Hd3nUw6Tp3hTQG7TKGAIx4IR8xBF92M9hKqs3FFkjsSG6BsekrO+ySNtfPTN61FwN0W4RT5HxWt
 vnSgEfNeRqXq+8rNTC/bCXp+bJmTz/w=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad79b30 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fjv418BXBf67NISfADsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: uVz_2zd-uKTZwEr_Q944vyUdtJ_NjG91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200066
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

Document the "reset -m <mode>" and "reset -l" forms and explain that named
reset modes are declared in the device tree (a "reboot-mode" subnode of the
psci node) rather than hardcoded per SoC. Describe the 1-to-3 cell
mode-<name> encoding and note that U-Boot's 32-bit PSCI cookie means a
3-cell mode with a non-zero cookie_hi is rejected rather than truncated.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Changes in v2:
- Document "reset -m <mode>" instead of "reset -<mode>"
- Say that U-Boot always sets the vendor-reset bit, instead of
  requiring it in the device tree value
- Update the return value section for the new failure cases
---
 doc/usage/cmd/reset.rst | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 78c9c8873bc..e8419a832da 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -12,6 +12,8 @@ Synopsis
 ::
 
     reset [-w]
+    reset -m <mode>
+    reset -l
 
 Description
 -----------
@@ -22,8 +24,53 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
+-m <mode>
+    Reset into a named mode registered with the reboot-mode framework, for
+    example ``reset -m edl`` to enter Qualcomm EDL/download mode. The modes
+    are described in the device tree, not hardcoded per SoC (see below); an
+    unknown mode prints the list of available modes and fails.
+
+-l
+    List the reset modes registered with the reboot-mode framework.
+
+Reset modes
+-----------
+
+Named reset modes are declared in the device tree rather than compiled into a
+driver. For PSCI-based systems they live in a ``reboot-mode`` subnode of the
+``psci`` node, one ``mode-<name>`` property per mode:
+
+.. code-block:: dts
+
+    psci {
+        compatible = "arm,psci-1.0";
+        method = "smc";
+
+        reboot-mode {
+            mode-edl = <0x80000000 0x00000001>;
+        };
+    };
+
+Each ``mode-<name>`` property carries 1 to 3 cells describing a PSCI
+``SYSTEM_RESET2`` vendor reset: ``<reset_type[, cookie_hi[, cookie_lo]]>``.
+``reset_type`` is the ``SYSTEM_RESET2`` reset type from the PSCI
+specification. U-Boot always sets bit 31 (the vendor-reset bit) when making
+the call, so the current vendor resets such as EDL use ``0x80000000``. With
+two cells the second is the cookie; with three cells the second is the high
+half and the third the low half of a 64-bit cookie.
+
+.. note::
+
+   U-Boot's PSCI client passes only a 32-bit cookie to firmware, so a 3-cell
+   mode whose ``cookie_hi`` is non-zero is rejected rather than silently
+   truncated. Every current vendor reset (for example EDL, cookie = 1) fits in
+   one or two cells.
+
 
 Return value
 ------------
 
-The return value $? is always set to 0 (true).
+The return value $? is 0 (true) unless a reset mode was requested. It is
+non-zero (false) if the mode is unknown, if ``reset -m`` is given no mode name,
+or if the reset into the requested mode could not be performed. A successful
+reset does not return.

-- 
2.34.1

