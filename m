Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFE606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=A0EKXlic;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mn7n7nhg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YoKMZqqi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D44081100;
	Sun,  1 Nov 2026 10:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 150THYX3sxVJ; Sun,  1 Nov 2026 10:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A7F3810AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528418;
	b=M3VBcmpWDDvyAPB3wBIa9s66wyrUWEtIjerEVWh5dxxwY7T/G3AIQa2xM2zrWjLNTJZE
	 vNvFcdIqK8Rz3XaGUrocNmQLcRq84OHxr2b4mQfe7FiNOZLoZT9yRkCya3LlLC6DhmecN
	 CjPXlBF11CvCzXHW9oZTonGmBA94g9Z3lxUmBKuX+hfLSotzXLX0V6IMHuW4T8R7DczBY
	 iHNu54//Go07yQTgzZpl9j44lx1K1XRZLKc1wsJWxHhP/FagWX2M5w2BTtILlpOL7YxLF
	 6cjDm0BtH8OCQ+pnlsEwkuy1HxGGY0cFlotSI8mooRohqE2vl52iSBEt/lusRHn90uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LuLXwNuuubYrfGAkp7kg40h29xewTqyC5xqaDVgMhe4=;
	b=n3nPLS9Bh8LXLWCLWk3CyhEFIxhYARp67on4ngdoj1rr4QeSVfvFgtZgdaZRCnVC4THQ
	 VwmVSGGhmyOrb0Mtrb2h6JLg9vLUXKSYQ1/S13MuHZchhBXUSbgD2EnC3J1PWIe8FiyW/
	 Klyxw1sF1hpdk957GPVTg94tM3b22hzmRlnPDiAGP1SIFAEruX2FcWL7fM2DdBhIUrPcE
	 r/2mhYPHpSqZaMblj7+RtmyemSw04lDzRfqMw1UX4mJwJ5zxOIaEWW+pamKZ7wwOhf+dR
	 UqbV8Db52A57iYUkdPvK7h/5L6t6gY08GjUBEzZxPP5FDqKEUyq+vTOejXMDDGnLEPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528418;
	bh=LuLXwNuuubYrfGAkp7kg40h29xewTqyC5xqaDVgMhe4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A0EKXlicdYxDzg8nUxrbEXLxomwONizxqXnfswWRJa83D2T9ktU2scmB9k0Fpk2B3
	 Xr7/KHYNVnoA1GgEG0v8l/EnZrKYDyTFhtWGvsqfEdNwuiDYS2MRfF4+GDdgGdzaUR
	 unzh7jSFB/V2BdFHwdAIXGpuXaiSp7R0GD9cKHI958MMdWoRUmdbf82z1Mf+V9JLRa
	 XnqOx3wT0h21etUz7ZSKbomMziWtDHdiaZvcfdJENRYQF1VT5Lu5UUpR57ue2tOQZQ
	 Y+NGrDUTk4zumnLsE0h/kXubJojk5xC5X678aNOHHAUboh7RRJ8bpIpxIqvR+o61nm
	 oIbVIfItmAoJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A7F3810AC;
	Sun,  1 Nov 2026 10:20:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 617C24B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EF7C405BD
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxMTBtyjqimx for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:20:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6472C405BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528415;
 b=r2PmaAcjwYFZZpCBuiODwlrfUBGAEhNzRQzvaUt0OtHSHSc0PDNGMc7RZD60QjhE0Zed
 m8ZI9RmYs3YT9RAJvQQr1+Dc1zDB80l44koP5Gyv1jUvV3TiBklyom/VKxTaD2ObgY3Wp
 qDOC9OLOznuqLnCVhh7qz+uLH9Uwjk9k3fcgW70ygqWNBf4qV70mK1pMkCt7YHnY46qnp
 Ww0blg0lHOhTg3ZTHpfvKvSU2+tkdxXeJoyhMd5x08Yvd5o7dwCcHVnRISVCuan30nEoH
 EoSz59Tl2KiO/orDYN0RiUG+sLClAyXPERUZ5JXtuhvgUSh62oCrUmh3R7J0TzrEXyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528415;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=LuLXwNuuubYrfGAkp7kg40h29xewTqyC5xqaDVgMhe4=;
 b=iAO2cw+KgybxgS4G03g/I9/BcsMtWdK2ts6jDvAWTQWlu0dm4zrvJnYyDgY9T9YdE1JX
 jfS0cVHkeVeKqPzL5hi9B2RITj95jWoILXybg6h0Wx4tSTOn567wmRp25jtneZGL4Mtm5
 TJlC0mw4jJh2G5ANFAXueNEMDB0yKAusYq1sa/lKgKi7KnKJ8I0MBbLM/RAGa2X8xE9VJ
 qpKIeKECNcljXV5e/MmQ1iWCdanfWwSSo+6n4Wjt0vazf4/Ws+TSxoiXTwg1tiU3c44fr
 q9Xp6ZRP0aqYRyVpftjdARKfhmnwg1wteIgSnhueJJEPPYuE9+ZDdMUD9v/ZTmUsIFw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Mn7n7nhg; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YoKMZqqi; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mn7n7nhg; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YoKMZqqi
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6472C405BA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:20:15 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18JsSj1359027
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LuLXwNuuubYrfGAkp7kg40h29xewTqyC5xqaDVgMhe4=; b=Mn7n7nhgHg6DO77g
 6wfh6c5fRSvj8TzCMvpmBe7/ppvHcDcA0ffurjMQ3oQsjo26U3PDoiI5VDoGs93R
 uR+hP68Z5EQ8EQqrq3gseGHFKTKjBOtGr/Hv6aOPYAm1Vzm3Bm5yD9eeAj29/DAX
 ICtE4V/C8CsGSicA0TK2M1wn7j/eLeVm3+wo27tFcjaE0ifiJpzvyLj6xrDS6mx0
 Ft93s/qLLcV2hVRuyWCsi/9Ha6BOpaIgv+nkQC5O5sthqXG+eErrOkGLOXWHxKRE
 Om2gKSJk8FUeVhpWDH0FN06O5lijonA6Q0CKXU0BgCPPEJxcuyo8v1XEjvCcpaSS
 pBjcUQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79ru8hg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:20:14 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4212146eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528414; x=1794133214;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LuLXwNuuubYrfGAkp7kg40h29xewTqyC5xqaDVgMhe4=;
 b=YoKMZqqizRYR27Eeha2C3Vk4euFmn+DYp06kEzg0whVYJo4A/JpFTEuYZ58QArkZma
 x4CKKVkWlra8fcgmwWX24bq+KCGZnhasFrcrTziSarPnowgPye3ICbcAHzeqClgxW6XH
 roY2Vz1hVatJiyh+XhgEo0IemLUu4O5h8WBnDosktuq9dsW/u180K3aPe7PE+YKN9h7B
 SBRvXt370/IlL7gRW4V2sDNg3Cc6+5lydgQch8fRmXY98zn4W8BIUIXRDAvbyjSW6ZMn
 +ILdewa8vMorCY2XKO/jYmicYTW7EBQE+zJWaYJoOvWy3kLA3uYcgUVEMy201sUANC9E
 6e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528414; x=1794133214;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LuLXwNuuubYrfGAkp7kg40h29xewTqyC5xqaDVgMhe4=;
 b=M5Ixson0JoQMRsOpyqJ+TpBhLsb1T413TG5LDZVfbZWvRRO5RgqMhWZdvVpCdPYi+C
 P2XpRzwaf1yakePDYnCKh7wcvKwvcnstGBOf3ACViQpD5YjNoEQQTTIYF/Td9DtjXE/G
 biA0yWcakFExoU/vx9MEkOCOAvXF3XFrVe8iK8BXMhaYaPAmPoQriff6sHz5mQCAe6QL
 z6mkkwjSB/4H4y0e1CqDIGeB3DveGLLd3uZrRuNnFH4iHXn2i/n6EMms9u9lZaCwEJsD
 dM2Lf5BbEhG+ehqhoIn+Ub9Pfz9KFj0aJ0yN75esM1azgTSt8g/MWSkjacl52WIBiTGM
 69+g==
X-Gm-Message-State: APuU4Z+JhnmXMMNEXIHTHgQ4FQDTN3DxIxXGRzGG7TeEc+istbPD76EK
 5Pj/k8sVT2WfST2/P09lJBUrehgxhUZXXNBRYyyL6BW9Quis/1pce5sA7en02NQ+d1ajOgIZG+/
 xWg2UQ2kB7aj75HKMl0sphq3bQi6Yah9sKjxk+WCwuoXLRn9w4fVosWjidwv4UWrUGM5dgJ4=
X-Gm-Gg: AYBFou3xYDC3DPA/crloQMrpN95vqPCwg7JWL0/5DD+/Wl9yGfZLiiJEU6Xz360UxiX
 uID2CCSObMNGpXFcrg1lF855Ay6YDp6+4MiHqZj8XlYWHlcW6XFWaALn5+ScP5I1NyvBUV/g7Kb
 Mi+iTI3W3W3BdPERcycOR6HHGrGBQ9dzyUyZVsYxRvvHx3ZuzZ4iD+TWbW/Yezj3fMyTy3cQw2w
 Gnu/SiJPdeCfzRiTPRiDO8jSSLw03DaWnj6ppxpUeaf0euB2YhKzeO6+D6oY9svBq+M4+/gv/xZ
 BmY+BYOHUqv2jg5A3bbrkXDrKqXMVrLrLLraJl5C1t93kvh1L4yKFDuHKu1JpLK1oChNzvY3qJ4
 62sAOS7QNMkX38PTtpIVeFrqOO57gwsgOf5eCdqskzIHyY2Vy9K0T540dtq2PVn3r1IMJPeSjSj
 2eMTEHfRCEBRtzzbUocEiq3C+KohQ9Z5Q7HBZCOeqvumWywrEyked3tRIICzEnUyN6StWOuYvfb
 S/dfg==
X-Received: by 2002:a05:7301:6f09:b0:36a:5126:a8aa with SMTP id
 5a478bee46e88-36a5126a932mr6861440eec.27.1793528413802; 
 Sun, 01 Nov 2026 02:20:13 -0800 (PST)
X-Received: by 2002:a05:7301:6f09:b0:36a:5126:a8aa with SMTP id
 5a478bee46e88-36a5126a932mr6861409eec.27.1793528413251; 
 Sun, 01 Nov 2026 02:20:13 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:20:12 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 15:48:45 +0530
Subject: [PATCH v10 7/7] doc: qualcomm: Add snagboot mode documentation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-snagboot-v10-7-e73d5cfedb8a@oss.qualcomm.com>
References: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
In-Reply-To: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=4803;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=6+Okl2nfPM9/vKKEHebyTBika1lb1qYZYg8cMoEXqxo=;
 b=Oc6u19Ey4n94uzPn5J4Q06ion30Xd663xm6wEZhzB9LuXooci4Y6uusoFCC6NQqd/4K9xK4Vc
 yLH1LptkpoTD7rnyz/Wu5DOIQsDX2QzX/NYqfURR+TKwc07/MTHabG4
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: 7rFQQnALx2R7CCrQIfxvbGge4Y4GrLy0
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae7125e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=D3gdSb3EAAAA:20 a=EUspDBNiAAAA:8 a=-mjFUTYrJJ_n1noAqFUA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfXwdj5xFuWTuAM
 5VU4moa/O1rcdS6GaM9rOxEoOGSq2uMTeJF3QPMxOui3dWnnyu8WyEZ5GX7IlQE/8HTR56sl8g9
 gsInBMgwhO+fPvTcHg8ryc4xPsczqOQ=
X-Proofpoint-GUID: 7rFQQnALx2R7CCrQIfxvbGge4Y4GrLy0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX6CBeBetTddsA
 UT3n79EwnivRlLppXvdsPpwR6/mFq0ubgb+9KeRvRCVJhvJYmtYCpxAgv/4q/rlNaKlWi53MNxg
 +h00M4mAgFkVvmaQ5LKmV0gkdBQlmk6XjKQ6VBL1hBh3jAtw2IVlgmD/ExM2+noUuktuBI9mqHP
 atvf/bRSRQjbBRmmWB/Gn9zDkUHCKSHGJeq1P0S82lTaMsQ0r4q6rWI1zk0DzX/vrGxaN5L4S5c
 gR3uyIuVe4uBrWU83ulmOLc2dmknlmrXtvNVCrRhP121wsm0Ije2iieNcOzgtK6RXgMgwneBRs0
 QrH8iIFP47WdMq05yd0i27y/BQ8bo9Ja/6Bd5LwrbGbncV1qLjrRtnKU0sAMgCUcFljpXHiD21v
 yTf25qqsKgpo9vEit3SsPwcTiNSWCYCGY+Exhd5m4NcDjAIa6IgzWFj7FzMnhApiNaExFiVLH7/
 zj4zm5jl18ZHjMywdIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010041
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document how to build and sign U-Boot for snagboot mode on Qualcomm
platforms, using Lemans-EVK (also known as IQ9075) as the example, and
how to add a snagboot defconfig for another board using the
qcom-snagboot.config fragment.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v10:
- Fix the title underline length
- Mention the IQ9075 name and point to the snagrecover documentation

Changes in v8:
- Point to the upstream Snagboot docs instead of describing the tool
- Drop the "Why Snagboot?", architecture and EDL+Firehose comparison
  sections
- Move the build and signing steps ahead of board enablement
- Drop the list of Kconfig options selected/forbidden by
  QCOM_SNAGBOOT_MODE and the Lemans-EVK example section
- Replace the signing prerequisites list with commands to fetch
  swiv_build_utility.py and qtestsign
- Drop the "Expected result" and "Output" blocks

Changes in v7:
- Rebased on top of latest file

Changes in v5:
- Added build steps for U-Boot in Snagboot mode

Changes in v4:
- Newly added in v4
---
 doc/board/qualcomm/index.rst    |  1 +
 doc/board/qualcomm/snagboot.rst | 84 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 56b8d894c2a..b8bc37bb384 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -17,3 +17,4 @@ Qualcomm
    rdp
    signing
    spl
+   snagboot
diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
new file mode 100644
index 00000000000..faf5307e4bf
--- /dev/null
+++ b/doc/board/qualcomm/snagboot.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Snagboot Mode for Qualcomm Platforms
+====================================
+
+`Snagboot`_ is a recovery and reflashing tool that can download a
+bootloader to a device in its boot ROM recovery mode and then flash
+images to it. On Qualcomm SoCs, snagrecover uses the Sahara protocol in
+EDL mode to load XBL, which initializes DDR, and then loads U-Boot into
+DDR. U-Boot enters fastboot mode and snagflash uses fastboot to flash
+the system images. See the `Snagboot documentation`_ for how to use
+the host tools.
+
+U-Boot built in snagboot mode runs directly from the address XBL loads
+it to. It must cope with the MMU left enabled by XBL, and it cannot
+rely on PSCI firmware or Command DB being set up.
+
+Currently supported platforms:
+
+* Lemans-EVK, also known as IQ9075 (``qcom_lemans_snagboot_defconfig``)
+
+The IQ9075 board setup and firmware are described in the "Qualcomm IQ9075"
+sections of the `snagrecover documentation`_.
+
+.. _Snagboot: https://github.com/bootlin/snagboot
+.. _Snagboot documentation: https://github.com/bootlin/snagboot/tree/main/docs
+.. _snagrecover documentation: https://github.com/bootlin/snagboot/blob/main/docs/snagrecover.md
+
+Building
+--------
+
+First, setup ``CROSS_COMPILE`` for aarch64. Then, configure and build U-Boot for
+the Lemans EVK platform::
+
+    $ export CROSS_COMPILE=<aarch64 toolchain prefix>
+    $ make O=.output qcom_lemans_snagboot_defconfig
+    $ make -j8 O=.output
+
+Additional tooling
+^^^^^^^^^^^^^^^^^^
+
+In order to generate a working image, ``swiv_build_utility.py`` and
+``qtestsign`` are needed::
+
+    $ git clone https://github.com/qualcomm-linux/boot-firmware-ci
+    $ export SWIV_BUILD="$PWD/boot-firmware-ci/tools/swiv_build_utility.py"
+    $ git clone https://github.com/msm8916-mainline/qtestsign
+    $ export QTESTSIGN="$PWD/qtestsign/qtestsign.py"
+
+``qtestsign`` requires Python 3.7+ and the ``cryptography`` module, which
+can be installed with ``pip install ./qtestsign``.
+
+Signing
+^^^^^^^
+
+Add the SWIV segment required for TZ-based signing::
+
+    $ python3 "$SWIV_BUILD" .output/u-boot-swiv.elf .output/u-boot.elf lemans
+
+Then sign the resulting ELF with test keys::
+
+    $ python3 "$QTESTSIGN" -v 6 -o .output/u-boot.mbn tz .output/u-boot-swiv.elf
+
+This generates the final ``.output/u-boot.mbn`` binary, that can then be
+used with snagboot.
+
+Board Enablement
+----------------
+
+Common snagboot settings live in the ``configs/qcom-snagboot.config``
+fragment. A platform-specific snagboot defconfig includes it on top of
+``qcom_defconfig`` and sets the platform values::
+
+    #include "qcom_defconfig"
+    #include "qcom-snagboot.config"
+
+    # Address where XBL loads U-Boot
+    CONFIG_TEXT_BASE=0x1c100000
+    CONFIG_REMAKE_ELF=y
+    CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
+    CONFIG_DEFAULT_DEVICE_TREE="qcom/<your-board>"
+
+    # Timer frequency for your platform
+    CONFIG_COUNTER_FREQUENCY=19200000

-- 
2.34.1

