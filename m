Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B6606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wFGj9SyK;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M8mZG3l8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DssVsWHD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B84080F7A;
	Sun,  1 Nov 2026 10:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vE_INnnGseXz; Sun,  1 Nov 2026 10:20:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B430D810B7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528400;
	b=kcIvFL1Xoz1eT+Y8zXwFdtsgdEnYSyj70h00qvMmBQwqam0ogqZmlovrEI7zZPsnULgo
	 AlnkkUOGAPr/bkwWGGw7+UaVF81V6vdrpVihBGl0weUAmZRnmUDpFZG6FxliRhTjY0On6
	 0UFMJBKlKsz/ciaBvYgpqt/J+uIh/SoztMQRw7xOtcd8dNPH675ZTx2kyOw6K2zL4yLho
	 3NORgOwnNosSjvDjQXGc6jq7zJxI2q4TRzqhhsx6gmCpmLGxjEhNnT1uSUHw0NiNkKYfP
	 6QkiW5e7w2kQjhN8W9vz7nwpZS4tKT70iMN7To8zjoo4J/KMg143Q3iTBcTTkyCYu9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oTDkZ06arAY/AGXc3NMQRGPv81feOTHTzcUhyA8THKc=;
	b=bWAEanwyU4A0PDESeljo8xZ3zO4yYoPGgG47BaJbOwGC2cnswLaVSy27W0iBM068YjPG
	 1g2Lx8ZJCKUjJ7r/X6c9HKoKUMNODm0Yxd1tdi50f4cGv9wTGvaTMRM5L7DgiPVm+uFiu
	 saapcdj/BSe6IvU8J2cM8TwWZbr7ZX4D4jJVBR+k/zQ+8wIdhuaRU/0FEwFs1NacJ1VVS
	 GMNRizywa51LUMYXq2BaFPBry3yROXWrVtSHkLVY4/QHnYwSJv+CTxn7+xz6VA0E41Tpq
	 h1pJTpha+43sH2rm/xmOjn91/vIs6awVA9ciKuW+G2n82To3SMb59RV+zciO4sJlVIA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528400;
	bh=oTDkZ06arAY/AGXc3NMQRGPv81feOTHTzcUhyA8THKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wFGj9SyKBfPWXJHVqrtsPIRXOOcClyZcp86cm8dh3XnQ3vUna4MLOA79mA4SjySLF
	 ab6UoDI6sBA/UQs/cEANEBMgKzoUHTyQIp/5/85E6dKYUTl/gb4TFistFrs6awidfg
	 JiFHFFPFXU0LXxEufOIWoceKQHKbIaKnHIFA3CWM/4CItlQ7Culx9Ei2ZUmzoVR+aM
	 J7yMXWw/J3LoU+TeWzAAlL+hseGFPdRsk/pkVrs+BbzbF/8I3xJS+ZOhEWPy3siBjk
	 XzZgGj727Sv/yXNMK2FwW8wb3W8ZVAFdoJFm/MoLnotjICK8QhSsjKmx87RRiJZEOd
	 VTIqVOUAHeBNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B430D810B7;
	Sun,  1 Nov 2026 10:20:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C62A323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6DFF5405BD
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tIHVkCzSO0Oh for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDF13405BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528398;
 b=gsqfUBSm3ZCPJZz+rbk31TsTfzVTgCsuZkw62rFm2ym53muu1Af025nxxqLlHozBJU8a
 gjW4vPzT0Ta1cQ7dlqQVfqaZRgHof9t5953gKiZ8/anBNZSJTRKm4+RAs3oy7+MieWJ9G
 t5L7rfK03LnrgNLnFMMMsVB+360FXYlqe0B5n6fUJZcyfjyfMVn9JyGP7yHWHjuD+cTgp
 Xrsp17uOl4D9Gzxn4axkF6tc4lZV6xV89JJR15VmMD8LQj8jXTpyfo1Ww8jp+vuj+OrRQ
 ojWjWXvOgJ6/8k4tGx3Ruv9/uF8P8L5IkO4jKWsPGvgp08qpCPe8/7glwXcSjRHz2HQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528398;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=oTDkZ06arAY/AGXc3NMQRGPv81feOTHTzcUhyA8THKc=;
 b=JYvC6qi6avRYartQxtOsb3isb69F3wnOQS2bZELYQbHty0TcCVn+24LI9xgI6PKwtBbu
 /E/PlWRBuaLL92ZdMrqHkhHdLidJLXzkb1J7UnQIkDpdu8ysFxYXToZswj1/sUQ38g/Bw
 YMuSWfGqkU6+z2nM9LFkoJyafcIVz84Rk5nmgrVACsJsJU2vUjqTVOYxa0H7a1uhwsgLr
 cmYVsryy81T29MK8xzO8rVonLjgPC1moRTFupV7Znc0u319EIfPDvLtTGopqIYw+4eiF4
 0sAUXuPh+NGy7Jcc2Ye9R2WZH3W6abQqQ39d7+RFItOAa4ih8Z9tytJam2aWxzEvCRg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=M8mZG3l8; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DssVsWHD; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=M8mZG3l8; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DssVsWHD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDF13405BA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KQOb3977998
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oTDkZ06arAY/AGXc3NMQRGPv81feOTHTzcUhyA8THKc=; b=M8mZG3l8/BfO2X99
 QBEzr3CYdZAqIs2nudC3CxYP7Jcst/O9YaFR7JqlzCx1XumUnM6KfxMTFcvvIcge
 7KFGcvzNQU3HtykHasMdZBzO9FPlCZOc5qJA6ZcGPSafSTw64wIjPmqsx2yJyZB3
 MYi5Y/zUKw42Opp+s8O60UC6mxHAuAqi558lLGPio9dGUGTinlZjJRhOtZzrLU0M
 a7EAv3C2vD9Xqi4HET6g4Ocmrkq9tIBkLzyqR/rVrGeiN4LRhMhebtfDDrGL4XLq
 /yvgpap77Huc6ovpqG3uM5xh/HMsfHHK587twoCraHQ6FCuWgWSSf2QNbR/SN+UO
 bTashw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn93ek0hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:19:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2925108eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528397; x=1794133197;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oTDkZ06arAY/AGXc3NMQRGPv81feOTHTzcUhyA8THKc=;
 b=DssVsWHDKEQeeEtLprK5fLv9qulEYPCNV6YfJjBIky9YDGIpiUZ2x/nN9AbwhsZuAW
 gqeLbKq4Qom+g2c1QYB/fSKlnzBK56zRnanNv5BNIYdfaB5hsIY4owI9lJf/RxFA1Eav
 ieM15J4AwOjlMGe+IdDKI+MvRmHrbKcznQJtLwMVli95on+ghN5jecxiveqdIYYk4Qsk
 aDO30wnXiXodj4BtdPDnANM0h+DV4SOqCL5ZrquBEBb9yaQnjNiEXN3YeEvrXpUHrAu7
 4wNXm9OLJ9A0db+TXWutb84BwbtlSdD1vS+AB+ePD8NiQp/DMSEVAyEjuxfaTHAdLgyH
 1New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528397; x=1794133197;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oTDkZ06arAY/AGXc3NMQRGPv81feOTHTzcUhyA8THKc=;
 b=iYhhgBjT8A5BeVLImsq+4sfaGT6TXinWKCDkkW0xy8QCuNMkCc5qK0lcs1ykuEjVYO
 YU3qWS1RZcyV4DMpsBnBVm7klVbQiDDtKC+5kmg38Wu08Zu+4AeUdGItLrfCxH9zIM9j
 9hlf6cQp6CigvBtHBX4zfmRKxwJmUyIcj0EjoNNhqY2yk3Do74sDG6UaeU1PivtrAcTZ
 eRRbbCrIJj55nJNZZjrKzM09HdBLlNUmq/hKb0jwY3G7utBV7G1qVjXJqyab3q767eIR
 pMQf5y0o/F6BFRHJcBYvbQBl8VeseoibY8lIh8dduDdrcVDksb1CHbhrpNXLaaoZk18r
 VVqQ==
X-Gm-Message-State: AFq9FYJDWAnDuoTp5lnyv6y0Q4jzx0hzvA3WZTWVXJ3qNHtKZ+IW00pF
 JxC7gdEAm7jbbi1XDUb7BLOQCwYzpDBAzqmqiQf0vnKGaKFW1s4hoF78iZrzDkeZ1tcxN06C3pt
 iy0tirSUQK4tUtdCqJ0i6Ghbgk8M+fdcjg2pxrH0wOh9qcxXn7JNLDcIvQkweYKVRPZd2BMQ=
X-Gm-Gg: AYBFou2vN9klhhyM8vQ4bnmwRA01+fPlpmgRE+C1PDcq4gv+JuJa1Tt1HkVtT43MN/V
 qootEvLG1bKUPR2imm7+o7oS8/9sso9p242HRxA/qJeg0En72HbTDVazgJUe7fu7KRoH/kiUJF/
 bVdfyDRya1gzlqOA+P8jseJmeQMJ5BeYMpYU/aRKqALKc25/KSBvWh3pO9AUw0metvC+Rc3pXNa
 0kadGdAGjZ2kHsscrpl8vvaBW3SklLFzKo0leMDrvwqBpjc4Dk5GyjFmxv7HyLoVclNqCgH9+2q
 uvVYR1C3Flm+mCjBo55Uafxl+w+a//0BhGvqvQ4XNIEneR20Br+ZvLGupYq+stoc0xVMyuYKkVK
 /qs2/qc9ZyGqK0qEIKbKPSW9M5UfaOfinc4m+KBMaEmKDqPzD7arIbWU4qNyIoteqL5c1bgWK2i
 y4YxQ2yojiFPx8i/5UJ8ZhwNWXxOKllSQr3BptP5K/99v79r+ENNBaE2WwqEHXpj0n3WOZDZGDM
 LKGTA==
X-Received: by 2002:a05:693c:2805:b0:36a:4009:58f with SMTP id
 5a478bee46e88-36a423e5474mr10726571eec.22.1793528397227; 
 Sun, 01 Nov 2026 02:19:57 -0800 (PST)
X-Received: by 2002:a05:693c:2805:b0:36a:4009:58f with SMTP id
 5a478bee46e88-36a423e5474mr10726540eec.22.1793528396690; 
 Sun, 01 Nov 2026 02:19:56 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:19:56 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 15:48:42 +0530
Subject: [PATCH v10 4/7] soc: qcom: Allow RPMh to be built without Command DB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-snagboot-v10-4-e73d5cfedb8a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=2369;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=shZTbrBrSg8fMhWtp/JqRot0e6casfmNE6621DJTsjY=;
 b=Ysdunz0uHnirkRcDeR6oI/EMokQq+GBgBprIWbOzaAMEKZ2/3VjEyHhA6BoC/ptKl9TJfsS/W
 DdVVDU36kEPBhYiWnUkmdyfDI2/6r6WXdryaD1K/gokoY1t/tLFfVJ8
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfXwRuxwNXMpxVf
 5D4M0sI8hFy2QWiNEcSOXdcGcLFnhhjgK4nEO5S8X4Q3iFoavHN7m6/3cPWWyYHiW/ZDGpECK+I
 kZy6ThB3xOVSUS9+Bq6ty3wqSk/VNCkut4lYZYYWoMp7F5VjUpHb2QwEgXo2mUbbh/jqH+9JkF0
 Fb878Gq3pAFkVDmiUhY6oFVg7dzmZa4z3L/DYXcSMmaTFvhPmt8ljacJWXaZI578xxLrPM6/vCE
 k4QBM+Ia9kRkQYODdXdZI+j/PpjwTHJu4D9za5d6KR1PdQYzbc+Q2XJgcyV+5+hTp63evXd87IQ
 9ZJPZS3PdLCgqWBMqj/+OgOAaDm8gWcbX+3q9ffe3vbs+6nH6bE4/cTSHhBwq4Fb0vs4FdPtJd9
 WKFUlpgg8c4QbS2bOpEd9IMAxKJpXwokgYfPDM5sJzXM9UFxnhcS0u4u2CF46Ermw2+qDDWLIGA
 8733lC6+qnRMB5AcJtQ==
X-Authority-Analysis: v=2.4 cv=FciiV5+6 c=1 sm=1 tr=0 ts=6ae7124e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JIV6U4gh5wCYVv0GY9MA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: -Nltt_ohzwspjpHmAYQ8pqZvWeBTzPT7
X-Proofpoint-GUID: -Nltt_ohzwspjpHmAYQ8pqZvWeBTzPT7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfXysETagMykdVq
 fgwpLkFs/a1n//1pjjKfJn2tZ+mqKGNizaESmLUY6Py8OSaBKiuJK13n3OIabwvREm3pW8jBEYn
 IRQ/aWd1ebT9RrWYpyLbiB45cYqT5fI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QCOM_RPMH depends on QCOM_COMMAND_DB, so the RPMh RSC device and the
children it binds, such as the clock and power domain devices, are only
built when Command DB is enabled. rpmh-rsc.c itself never calls into
Command DB, only the RPMh users do.

In some scenarios, such as Snagboot mode, no Command DB data is
available, so there is nothing for the driver to read. The RPMh RSC
device and its clock children are still needed there, for example the
rpmhcc clock used by UFS.

Remove the dependency of QCOM_RPMH on QCOM_COMMAND_DB, and add stubs
for cmd_db_read_slave_id() and cmd_db_read_aux_data() so that the RPMh
users still build when QCOM_COMMAND_DB is disabled.

The stubs return CMD_DB_HW_INVALID and an error pointer, and
cmd_db_read_addr() already returns 0. The power domain, regulator and
interconnect users therefore fail to probe with an error message,
which is what they already do when Command DB has no data.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v10:
- Newly added in v10, replaces the cmd-db.c change in v9
---
 drivers/soc/qcom/Kconfig  | 1 -
 include/soc/qcom/cmd-db.h | 7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index cdd9e30f43e..1799925f07a 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -20,7 +20,6 @@ config QCOM_COMMAND_DB
 
 config QCOM_RPMH
 	bool "Qualcomm RPMh support"
-	depends on QCOM_COMMAND_DB
 	help
 	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
 	  if you need to control regulators on Qualcomm platforms, say y here.
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index 16609ac9d78..0d5693decd1 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -28,5 +28,12 @@ const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
 static inline u32 cmd_db_read_addr(const char *resource_id)
 { return 0; }
 
+static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
+{ return CMD_DB_HW_INVALID; }
+
+static inline const void *cmd_db_read_aux_data(const char *resource_id,
+					       size_t *len)
+{ return ERR_PTR(-ENODEV); }
+
 #endif /* CONFIG_QCOM_COMMAND_DB */
 #endif /* __QCOM_COMMAND_DB_H__ */

-- 
2.34.1

