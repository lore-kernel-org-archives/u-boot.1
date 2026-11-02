Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8D606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jQWzDuqb;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jrlU3QjB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=alkNz4Fl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0893A40506;
	Mon,  2 Nov 2026 22:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOMaPhrvUX8j; Mon,  2 Nov 2026 22:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1C1E740552
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793657555;
	b=W8fUjygsX0vkipuycQAQja/27owhClLK8uGyq6ZvDTMkZo65erTKoIBhhkaEBkG1PXRQ
	 on86Z10g6NtKNJU0PbS4qMM52NYTIE7nRyYxiyE0plHhn9X3ob2LUJUNCVh+1lJ75HYH1
	 wLSMyTRyjrqLEF9YRZPBSKDMswzc2+TEDVsNboq/yBJAQDIm+lAxM0ifUvboty68FEIEK
	 JSFzJgWl46llc/DkW2FSBkgjOjow6iRSNhiwLDiHuZrywHousRn+2+5l4V+9mjADJuWz8
	 DwBvqtBkZal+rmkN62fElnwAY5E31WvjNzqI/QDcD9kKkwL4YNDTLgpmwiJ7ZA5khqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793657555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ze3w0XyNNyWYk4vKQ50qPI2crhMP2dZEZ3HyFdpwGq8=;
	b=oMBwOT0opsX/AwDjWj+8niW5pSbgownRI0gfn5Glxpjce2MFH68rslXEiSjxiSBrsKpt
	 8cQKKg8jgx8RQvCjDaR7TEriIhTvLO3wWRG5CDgteCcMmIOA/T35xYtfxKyYlFL3DsBR7
	 MMPBngsKF1a+Z/rPCBFEDLp6s+tX0Kk1djHi8ir8qvCSY5lEYI0L9SVrHi4aWGEK5TZJ8
	 4L+sXkD6xP6YJufXQzB0UozuGG33uMSQ4aZNKziYytOyvSX4klNudKYesYnM5KZW6KSqt
	 +FfMKDONUyIjzhCAu5A9aaemt77P1cdAEWv4tPbYf+MStq7VVM8+3E/FXnxBKZlfw5g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793657555;
	bh=ze3w0XyNNyWYk4vKQ50qPI2crhMP2dZEZ3HyFdpwGq8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jQWzDuqbts8rUSLspJsPEuaKbmluL1MJIt1oyDa2vpIa31XTX0hN4kt0iQrrbV2oT
	 BVH7LG7E+BZtZ8UnOnwPlm/sjUZK8RavYipJLRBJhAJkylL/RrDKvwPcf1wyRwyZAP
	 a6UNZPnZexQ5pagQAWFYKMMqPsxn9sCzS7e626dQrs2P4HRLx6rq6ZY7aBZdpWfvac
	 cc1L3QVgGsWNdDHjXT0qRZpcY9jDrDCnLVezBg6b2iuY0OKj+5a9lS3zolx71JFAaf
	 EBxAWmdDOgJQApwD2qb+zMUtOHAHMbn+m6HADt1RRtpje6LmwjQE6v4wFCmkHGOZFN
	 s644Sr73OStuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1C1E740552;
	Mon,  2 Nov 2026 22:12:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F76C356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 052FB80CDA
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w8iMewE6rQO0 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 22:12:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9ABCF80CD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793657552;
 b=TRgiJtBolHjhKSQBKAqLy+dE5oEIhuhKaQy5sdBwcFW4CGV8DLqzRDXabEKZWgfjitnI
 H+To09EH7B87/S1t8kNhdhe4NwgFI+LwPU5JL2nG/4iST9yXPD2gPF+6rron4HvyTpvGG
 jlxTCILdR6px6Daw2N95Aa/Z2RlkA4zCnCINkKI9OCzN8b5+m/xbZ91GK4wQCapLG3nLT
 P3fuiavcxKLjKVuuztiyDMx1FNCs2lLGV/ivTNEW3GDgSqhnw2ps5wle3YDiQL72T8fKZ
 2yFULo/guZaY9XglirIDwvF+plGMwgreAUXJkviwZ4bjVnv7FVVRT73nooyqyr9rWtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793657552;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ze3w0XyNNyWYk4vKQ50qPI2crhMP2dZEZ3HyFdpwGq8=;
 b=Bi2WOnXwt8iV0HBBgllqjM6W6bmIMpim5Hi9Pa1+hDfow/M2m93IhHByM4LkEbag4sNx
 3fCupiBZ52t5O01+yUOj8XB6/lrwKzj9YVdj5kSbwnvu7kDvaUXJYh1IZOoA9GSAbC8Au
 pNBHljQ7MdbbcbqQw/wgcrmFJ5/pPpvRM6CuH6YbtYhTCH8C4rpO7tU++3Kk3rX6HWCPQ
 imlZaR0nV+liy6ObYPrqMD9EZhWv0z5vFWKBxJvZAbD/q1pzcvx3eK5toJMKzqZvaR4jq
 yBkTgE6FH32MFn0rO5rNqYLDohBbTa/4Wqof/ld87HhpIzjzx6z3kbrBiin2Nb9IcsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jrlU3QjB; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=alkNz4Fl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=jrlU3QjB; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=alkNz4Fl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9ABCF80CD3
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 22:12:31 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K6Xrs1325098
 for <u-boot@lists.u-boot-project.org>; Mon, 2 Nov 2026 22:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ze3w0XyNNyWYk4vKQ50qPI2crhMP2dZEZ3HyFdpwGq8=; b=jrlU3QjBkp65l4Yx
 G1cU16wzipjBpk1hTXVVC9mJmGpRIevYgOXAPzCeRE9zqihGc0s5PeYFLV9U/3r0
 4vmZUwbttcTphk/nF6J6yYf8KS86uU53ztQbh8MiStgDQcMKOTl2dn7xo6mZNKuj
 mKv4M+NddivraBjnt9yS9PhEfWLe37BxXAi1SvRybq7X2vz8mOGTPvzsvt9mefUp
 vI/iFIjGRcVH/P5Lr5J7GKR1R0Sa0Vb4TUq746q6yjQHuAC/391+Pinj7I01WZ6t
 VN5xWzgN1UXMyK/d1Ui5eCK+ajxQB/kbUYZ1inKOvYc3HucjiKo8u632a546KMe7
 sqWtXw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpph1bepx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 22:12:30 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b0adb0b8dbso49232487b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 14:12:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793657549; cv=none;
 d=google.com; s=arc-20260327;
 b=mdXp4ByrxqIshc1dgbLZgIhd1rGOo8x3HvMzpPHQs6nKQHLAUk4e5yiLTDLr+qxq2B
 D4UNrCt35ViiPW/eejcXHwcqXUPecflYG5gaoD6aZkgysisz3Qj+uJoK4DZzMlqEveI+
 MhgAe7IBoAkunPgI8sMFT7cSscmv6woZ96cRLHk4mLGNJ4P4oN/bxJbjLeht2B9rTgF8
 qivaoOSo2RtqDNIka5RbsEUfHGNcrH2d3Z2IAvlFrrAsiyquz4H5bmatFNKn2J/smyS2
 f+XkDO+1xCKvE8Uzb7ZQCNJj48Rw1oBJEcv97Hgw47XKrAXxNuH1bWzR/Il4qjZi7O1C
 jy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ze3w0XyNNyWYk4vKQ50qPI2crhMP2dZEZ3HyFdpwGq8=;
 fh=xjC2tbNKYyftXdBx4SZSkXSHpFfiR/DuaAq/PJepY9Y=;
 b=G3b3ZN72fYln5jPxLkYqefdRC+xuBqi/nasvbyaYYtEDGKjzG7+iy9bO99Fq2GQ6Q5
 BKONiu5p7Bg8ot6roTUta9wUo9UO5pNtTf/T4fy6+mr7/w9ab+sNKZmTDiLq04YyzgfF
 CRVhSjpta0sabWMAQDw8v9yjW2P2A1LysMnRda3IBYvPfJKSSmA5GkPfwPdZULyDbXtn
 Vlct0PuHq+Rq1rhxi5jbk4p1RyRrgMdeU9lm4KHSQ82eFDYer0Mwo42/Lh/3zA/8T/SQ
 Rv3NpesbxhggAIMzYpBTpXNhST5BiuopbtaqMpH5rtKunz6sMcaufSW20lm7BNbfzPLi
 Qrfw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657549; x=1794262349;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ze3w0XyNNyWYk4vKQ50qPI2crhMP2dZEZ3HyFdpwGq8=;
 b=alkNz4Fla12RbX2gwHDaExz5ILpibU6w/WgneZCpfltJwABoMIiBR+BQTHzLLYjX1p
 Q5D5e3mWUQdP0Fedz9v/lHVPSr7+7dCbI6ZSBRh/KFSuYR9ta7gXLhmmkiW4WOPsS9iV
 2AaRdW5c5ZbebZfZ7a1kPpyQpS6NvfvhOnAydTw2OczhcAntZCOCPvLMK+Lz1ZctnO57
 OGkEoom+ALmB3kMMapFbK+EU9e0arP3FXc9U9yKU8R/1k8+T9Y3S7JF+0okea86nb4wL
 8/g54ZoIvrXsvuwK74yr0ZS60knuCsnB13QbqLPCry1JYDHzf7CuyFMgBboqMJAAVXOA
 aEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657549; x=1794262349;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ze3w0XyNNyWYk4vKQ50qPI2crhMP2dZEZ3HyFdpwGq8=;
 b=qiaH/bciqlOPd4q0JAslCA3kazR7BhwtYLQIVBReIpmVTVYzzqH14hWECHUP4JR+fv
 3R7mU+DQtVT/jlNQvh8ftrJl/c18/kDBupbkA1+Vt+AHY5XX5k9VDeknaxejkjiXo8h+
 DXJgvey08QtVfzgXrR8rzUevNPGVgjlTHnKp9BJzCTgGLgzgs118ivmUrgX/K5ygWFrL
 s74p71PIvJImLDujSQzzGnS3MyajM4f+pFYLQLQwd/BC5lQsenJUPtKz+CN+Th81JFph
 rNDxk2elC4GH4+ojdSHzwUk6EFTmMOz4FxDV5tvWlIo/NFzB8nlrrFqxV8P0GVsGgOR7
 NquQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVfAAHs/3dipB7EXPoOQuBhSR4kCchq5znWQ5Yn/u5KPtbQMXGRNgcHDV3qXTZZ+snkgbb+7E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/S1nOX6ePhWxpcjGCNoNgUBNOl2l0bkWJvJgP3yfkYgFm+ZeLd
 AUO7914GLkm6rnqdI5HmVxWxfcUjDdNmla8obUA/OJvDoba4eEFSFyA50FhNPKUjEcmlYvUk6f1
 2mXV6j7kdpCWY+bTpTcXAgVT2GGSaWeDwHHU1upfFeSzGWDiz6XUoxwAfMYCWU27xO1tPn/TBB0
 0zMIdHPT6ur9vxG4t90TWHH9UEnqiKzPbeBvGlJkjI35k/tA==
X-Gm-Gg: AYBFou05MnfnC9icvkUoXLfRvxDZOCjiAzCYq/sKJXq/HKxbOuHReTSf6vefQ/XOMY/
 VqWsOe7RzI5fj7PkUiSDvnGz1srJN/CUM5oaOh+YZeyrEubXxukbqvoVRxTOciPqif20Vi3OVMf
 +d4OU3V3oTcpU6kr3SCJx9HIaDq5qYFhbD9+qLW/COzFYLExc/PBo6Qc4=
X-Received: by 2002:a05:690c:6e86:b0:8ad:bc2e:aad1 with SMTP id
 00721157ae682-8b2b66c4356mr87319457b3.17.1793657549402; 
 Mon, 02 Nov 2026 14:12:29 -0800 (PST)
X-Received: by 2002:a05:690c:6e86:b0:8ad:bc2e:aad1 with SMTP id
 00721157ae682-8b2b66c4356mr87319097b3.17.1793657548702; Mon, 02 Nov 2026
 14:12:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102-fastboot-addr-r-v1-1-7ef1a2ac8fd1@oss.qualcomm.com>
 <e3ef6dc3-90de-439f-b46f-b57f9cfbe64b@freeshell.de>
In-Reply-To: <e3ef6dc3-90de-439f-b46f-b57f9cfbe64b@freeshell.de>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 23:12:16 +0100
X-Gm-Features: AclHuK9gq7cHqohOEh52aQ9rsFn1XQmWkWWMBfQ8dxPujbjal5RTJB0Ccjv9rIY
Message-ID: <CAPzfCAauD7HMLG_8d7iELDgtaNUzxEJ50ukjkdt63vjBo_0rOQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: fastboot: default the buffer address to
 $fastboot_addr_r
To: E Shattow <e@freeshell.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: cpjPz327lHY3csqM7E3SPHpvamDT3I7m
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6ae90ace cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=ke83cXcdTt4a56xe8p0A:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: cpjPz327lHY3csqM7E3SPHpvamDT3I7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXz2sEwfHa8T6f
 zX00mBORiSdmeJDPAukHYzSAg4nn3sXsHNxh0w+EPUI1oXer/8E+R1uD5Pd1Q7EWXxhTTZHm+Oq
 mMW2SeLUFzQPBWFcGt/jJUeIODciyGONlGDkav7G6OPbARBy0w/ZLbhup4luBDuL2QEmc4L0nDZ
 u1nEMtf0BquCrfDhDptU1C6knBSQqdKDriV2cTW7XZJ87PsN1DoT42pXJF6ix0oJssQv6OTjxx3
 5FzFxI3XoSgcwgzu6+Bk6uTe6T3LqVG2N/+pBE/NJpFMZ4RiIqGGMptZ91b9ix4I+2k/yPowfdy
 il+RH2of8Tn2NDcbKCDwK3zGqm1YWDA51zbGN9OToxVYaDClD2AvEBEXxDIbfnIxAbRXw8jgDBR
 EoXp30S+CppOcyYSiBB/EA1lR04oiOjOI/fFZiUPN5qFgwSP02/bFoezP7REzrad42zgag9530R
 PRYAUHDHLR3/hC57AJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXz8pKKfOfFC/h
 7ImhBaUNTeQW2BKuCnG55uWCZMombSFLZXPcUCNeJIjaFZibFW+8WOnrW9V463awBc3LkVuWEU/
 wQ5KcGgUPz2bHPz8oduWP17tKRf22Iw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E,

On Mon, Nov 2, 2026 at 4:23=E2=80=AFPM E Shattow <e@freeshell.de> wrote:
>
> Hi Igor,
>
> On 11/2/26 05:30, Igor Opaniuk wrote:
> > The fastboot command downloads to CONFIG_FASTBOOT_BUF_ADDR unless -l is
> > given. Platforms that only know a usable address at run time leave that
> > at 0 and put the address in the fastboot_addr_r environment variable:
> > mach-snapdragon allocates the buffer from free memory, and so does the
> > Samsung exynos-mobile board. Their environments wrap the command in
> > "fastboot -l $fastboot_addr_r usb 0", but a plain "fastboot usb 0"
> > still downloads to address 0.
> >
> > Use fastboot_addr_r when it is set. -l still overrides it, and boards
> > without the variable keep using CONFIG_FASTBOOT_BUF_ADDR.
> >
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> > Tested on a Qualcomm QCM2290 board with qcom_defconfig: before, the
> > first "fastboot stage" after a plain "fastboot usb 0" crashed U-Boot.
> > With the patch a 100 MiB download lands at $fastboot_addr_r (CRC32 of
> > the buffer matches the file), and "fastboot -l ${ramdisk_addr_r} usb 0"
> > still places it at the given address.
> >
> > Refusing to start with a zero address instead was not an option:
> > sandbox uses address 0 as its buffer.
> > ---
> >  cmd/fastboot.c           | 7 +++++--
> >  doc/android/fastboot.rst | 4 +++-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> > index ace877b6e28..ce4a32729ed 100644
> > --- a/cmd/fastboot.c
> > +++ b/cmd/fastboot.c
> > @@ -7,6 +7,7 @@
> >   * Rob Herring <robh@kernel.org>
> >   */
> >  #include <command.h>
> > +#include <env.h>
> >  #include <fastboot.h>
> >  #include <net.h>
> >  #include <vsprintf.h>
> > @@ -88,7 +89,8 @@ static int do_fastboot_usb(int argc, char *const argv=
[],
> >  static int do_fastboot(struct cmd_tbl *cmdtp, int flag, int argc,
> >                      char *const argv[])
> >  {
> > -     uintptr_t buf_addr =3D (uintptr_t)NULL;
> > +     /* Boards which place the buffer at run time put it in fastboot_a=
ddr_r */
> > +     uintptr_t buf_addr =3D env_get_hex("fastboot_addr_r", 0);
> >       size_t buf_size =3D 0;
> >
> >       if (argc < 2)
> > @@ -144,7 +146,8 @@ U_BOOT_CMD(
> >       fastboot, CONFIG_SYS_MAXARGS, 1, do_fastboot,
> >       "run as a fastboot usb or udp device",
> >       "[-l addr] [-s size] usb <controller> | udp\n"
> > -     "\taddr - address of buffer used during data transfers ("
> > +     "\taddr - address of buffer used during data transfers\n"
> > +     "\t       ($fastboot_addr_r, else "
>
> This is not a good place to document the inner-workings, that belongs
> instead in the actual documentation for u-boot fastboot. The command
> usage text must describe what the *user* may input, not what the program
> logic does with it internally.
>
> >       __stringify(CONFIG_FASTBOOT_BUF_ADDR) ")\n"
> >       "\tsize - size of buffer used during data transfers ("
> >       __stringify(CONFIG_FASTBOOT_BUF_SIZE) ")"
> > diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
> > index 8e15f287f9b..41db4b31e16 100644
> > --- a/doc/android/fastboot.rst
> > +++ b/doc/android/fastboot.rst
> > @@ -70,7 +70,9 @@ downloads. This buffer should be as large as possible=
 for a
> >  platform. The location of the buffer and size are set with
> >  ``CONFIG_FASTBOOT_BUF_ADDR`` and ``CONFIG_FASTBOOT_BUF_SIZE``. These
> >  may be overridden on the fastboot command line using ``-l`` and
> > -``-s``.
> > +``-s``. Boards which only know a suitable buffer address at run time c=
an
>
> What is "Boards which only know...can set..." ? This does not make sense
> to me.

Agreed on both, sent v2. Thanks!
>
> > +set the ``fastboot_addr_r`` environment variable instead; the fastboot
> > +command then uses it unless ``-l`` is given.
> >
> >  Fastboot in SPL
> >  ^^^^^^^^^^^^^^^
> >
> > ---
> > base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
> > change-id: 20261102-fastboot-addr-r-28fe6ea5615f
> >
> > Best regards,
>
> Otherwise I think the functional change is correct.
>
> Thanks,
>
> -E
