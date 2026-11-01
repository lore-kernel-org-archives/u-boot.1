Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E265606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pAJa3u07;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d7F+FBU7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EPZUiA9d
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D58B381005;
	Sun,  1 Nov 2026 10:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nUw8oJ88EBxP; Sun,  1 Nov 2026 10:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 15C2E80FF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528397;
	b=rSsU7vMQTWVOjcxw3NsC0HbTMsZjzI5nRu3ROI+FDQWscCiSDkIAPIa57a47dfpdHVOM
	 GwQIG2i9ZcdP9SaYZlMeR7rnOT9TNvTgBylZFQu03dgmfihCZjQQ42pNyMNLsAUy++NPV
	 jmMUzGOevaDxRCnIpKRV9OkdqA2r+ATx3ZsxgNTC7WDwdSxFV+3yT/a3ig1skCmSw3TDV
	 DMFznxw/xoGe9JDUWUN0WvSaOqni/IFJS7Vx0jf+VdWOIqbyq1L5+ul3Jrky7Tyizpk+6
	 roeGS3yhJY2dHgWDR3CTkn94LGuW9fbJcEnaMyljuaYqNeX3TVdIgIs1m9VtnG/BQLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2LpQZns7oS9hev2pw8G3QH71f6wBwqh2h5V1jlvBq8A=;
	b=MEqCq4rkdokEjurKhSWovT5YenqHzp29DAWCrGCexCI/TWhkqUjhQExmimNPipS42ZKv
	 xwLcz1UVQugev8EM3MJ3wZQr0n2rlWicRIGLCyjZOOY6MZLyeeYcB9ft0OUuSBrHRuZCL
	 iwz7melZU+Co8XJlxTltkIdpqOIm/ywYbE+zqO3puiyVUtqUGGNckYycoNn56r/byAuVL
	 HYRjuY6U+S50z1bVk4jjCtUw7Eth1EmccpJ8Yx+tMbxUVd6/WiIJ4OrsszordC7ODJqmz
	 iHmymtsMAlTygsb2/3FYwysJDmoUWbSKhczIizrQGGLdrrXc6UAT3FcWLZSi7S2Hm0Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d7F+FBU7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EPZUiA9d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528397;
	bh=2LpQZns7oS9hev2pw8G3QH71f6wBwqh2h5V1jlvBq8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pAJa3u071YIJgfBK/VLqn8R1Q82KvEwvMVYFUamR1ZDXPPWM/NJbuIK5Y5CPz9dLJ
	 2BPe7rMdA9mrBEGGVs/+NIadfGRe5UbtqCmP82H8OJg9wGy5Guimn/vo4vZpNH7E2N
	 A8ZP84eGyYOGc8oaKJymYPPJW1F3SgoZ+PzUAk+1/wOmBFfhNy0VVVB7yTt28hig7o
	 WmjlXMxFXJzbv9D4Yox+6vUdTDgXbnCztcj2M610uzcpSnQhCJC5ARrWx6V1JjmJyi
	 GnnLe8MjRzPAWPed1Ankf9RpRccYxLoFEOE5FAOwj0fly5hJouoaAkuP0ti1SoqnTK
	 sNNRmlcC9Rm+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15C2E80FF4;
	Sun,  1 Nov 2026 10:19:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F1E614B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D740680FF4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O6FAxv64NgKq for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C1BC80FA0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528393;
 b=AzMDeNhGs1b3BiR/wBvfaRDs39T0x5IXnmAhbqiopRixKazvmpR4Rw6xeCYlSl/QvoW1
 z2j6E+izjbsJwb9lBTH/GKYGjQJh/Y7VZotNmzZ0Ir7JWIfrB5LmtTD2ozpWgqaXDO9Uk
 nxoTk2PqGOpbm3hZjgPFfECKTIf/IyOHxi14zXx1JYKoFsKQzp239sfcgw61YrfjjGs02
 VzPIqmet2uiyMgkYJxQK3pJhTxKazVqU0mT593YwqqPmANHiP/+p1lbFDoxanYrTmFDSE
 bvoMlX8Kk9xRGR7PR48rxWZ4yurchPPT3jaR/CCMYWg8611RBEJeQxkw7MWMZdcvQMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528393;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=2LpQZns7oS9hev2pw8G3QH71f6wBwqh2h5V1jlvBq8A=;
 b=NTge+P9SrH9RdOBR/cSX5tNWNyBHy8c1f5v2V/PQthYu8MJkBRElY+XiOlzDm+MG6Svr
 uSlRZY+aXOUQnsyop3S43KmKkSoRkg3zUhx9C9N+Dh4oz4fwwDQRvVmG9GhGGSaaxlhE/
 aSLvyoU0+P54JHWPvSEABYwPz5O5efmKjnJrUcZ5+ipdvZcq5OIT9WIhsR3jpj22koBdl
 tXFJWfn6JOaKFlSQzFP9efjYFhNd748w6oQRo6ay2gyIZ9LNF6VIANdQmE+C/8BMP77II
 zBHlwh6i4W6K8SBNWBSVqBR0qOYmIoMlfBePhW4tP2ncwMf+HefVS5CQAlU0vy8wUvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=d7F+FBU7; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EPZUiA9d; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=d7F+FBU7; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EPZUiA9d
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6C1BC80FA0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:53 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K1951320768
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2LpQZns7oS9hev2pw8G3QH71f6wBwqh2h5V1jlvBq8A=; b=d7F+FBU7yKMTsDRj
 2/Dl5IzRBzkX5lH0Kd6KybR4z4GVnmeI2EHyVu0cW+dTjKp89OcTwp3pr1vdHssh
 xud5ul/fc01APR8yRFbABYtD0tuWMpkMK416xD58//UA8+TcsBb9qim8B0OMmtY5
 r7T1nhXp0UUvo2ho00iqx4RR3oCnuSYBsTSwLswlLVWv/ALsr2JARPdOQt8FORkR
 d1bxbObntMLYdqYUyf0fDQRYgACQGenucGfWvKBTIetG+ies6WkB7XWe+S+v7ph1
 JZQN21rw4z5Txx7UR572sBAPibwPbYdl4VxhFP0W1jvKjxe0QnFhpUeJ1w4s0WHr
 WQlgQQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fuemd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:19:52 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso5045757eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528392; x=1794133192;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2LpQZns7oS9hev2pw8G3QH71f6wBwqh2h5V1jlvBq8A=;
 b=EPZUiA9dVaBjqD+PryNLs1jwiXDGg0zhVvdXZJ0+sDjQEfsqu4xcDiGMAIrF5pI6Ou
 khl17HRp5FslZck2Ef15iSkad9UTNwmei+xrsmAcm4xQY8RhKwE2NJSTl11mztwaP9Mm
 El8INKD4sZ4cqfuMI1I8enmCL5F79mI67CBVGok+H5WKOpUG1qv62jG0TIsflnSNzg3J
 x6VSkJqMXyUYFupMBN3wBWagKIm2Bg82naHI9q9KSmfEbAPijA5VnsxLmNfpW7dLAeNe
 0Fet0LZ4cgIDE36x5VfRYSUrlHeccdDQgVFDS0EDXnjGv9u90tXoh1kI1xOhGC6Pu3yh
 nFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528392; x=1794133192;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2LpQZns7oS9hev2pw8G3QH71f6wBwqh2h5V1jlvBq8A=;
 b=oKaA4DzfJ4oUT8rEha52bXBuinM+TknqbEjJAg2myrjnXVV6w7UyhDPYXfvgCanYgk
 ewB6cnFcEwZpMYg+KJ+pDNtHCYraZcU77whhMZIxs6ZFqykx7OOTPZjxLV4UDCBEMPLn
 cXWI1aM+4isu6dU4Io9JBLRZYkAk2IDMZfWEIyUeGcYCKet1WudTVVNjl3qOusaZaPaS
 /NaGzkoZ+dB5cW9hCNEK4EPLBhfXqnt2fWQokzAtonjFlqBlvZdzKYW2OBowHh9NSaDe
 dXeDZLVglfP9t1X2GaeH/cyRvOyO2pR/WK92Z2nLJ3Q65QALdyz3PbJxOL1cDQXEKiH8
 DVLQ==
X-Gm-Message-State: APuU4Z8gpp49QxgfFMfagfJvrGoGHP+SnfgnaRyRjIxtavVGwf8dehZK
 RwJ2pVDS5zjLdkXawBikeCilcafN/l7JB/SRJ5dQFsoaj1v3xc/s1aTwtAXEWKlgik70svHhhQN
 Ct8HR8A7VSce0jfoZWBsCdtPAZrKaaLmg1oHijb3NPGqC4wV2n54jF3knAwkbMLXJhoNs7pc=
X-Gm-Gg: AYBFou3S3csM6DVP5ffphBxIpH9kiJ6KRi7k1YxMMQJRuDQ+Xrx1wS5DAe9n0qwFtN+
 73hhAYwbsfddTgq+P87EXGD0RbAcoez7wVkACR/9L3dennwIESRuYn5vjFs3jEG62d9AE4ZZxbX
 7y815MXwn1B1ZH8F4EumR7dWDWz6sAk3Od1fwFfjtua2efngTQUVbpLJlRLt7enNGaitcunOQWw
 SucLIC5DkLDHnV4IGeKVPqfRt9RAaxL32jtzR8BDhwuE2+VWZsta5oT7+90x4dphd08p1XeHRhg
 hvvxfEsO+gqi4+GTuE3TuaDaaDuhgO2Iqzxm/P02TJcIy2UVwtOv5IAKCdceyPzTfh/IeWrO5jv
 SCe9oJxfNUUQUHIDRb/+l1DTQCGfRyaX+wBEGed+bzmVG2RFzhUaU2Npk9ZSDhMNHugYxGgTrkm
 vvQHg1OpI6TmHXOyETE/zW/c4TjIIP7rIswEP9QRpzRU1+xFEo5gHIp+y/2mT8xwMMuZsHb2StY
 KbddA==
X-Received: by 2002:a05:7300:aca8:b0:35d:28aa:3ae6 with SMTP id
 5a478bee46e88-36a4244e81amr15261432eec.32.1793528391955; 
 Sun, 01 Nov 2026 02:19:51 -0800 (PST)
X-Received: by 2002:a05:7300:aca8:b0:35d:28aa:3ae6 with SMTP id
 5a478bee46e88-36a4244e81amr15261382eec.32.1793528391244; 
 Sun, 01 Nov 2026 02:19:51 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:19:50 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 15:48:41 +0530
Subject: [PATCH v10 3/7] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE option
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-snagboot-v10-3-e73d5cfedb8a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=2090;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=HDT6nlNzMV60Nkj697eGdFKxp9miZYatOLk6bMiFlag=;
 b=D+q/5/MGyc/HqDWp3L+yrCJnoVem7SmfzMCFupk0k4p3IttiEVd5tCN1++4yLVrJqcDx/pKXf
 x1sSw6NWgNTC1ynrMeFfDXEhNgO8RhkQ2vXPGnj1tAB7Pun4MI1bw8D
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX65HjGIDQgAS/
 VaWfVnwPwWNvxiV4JS0EefowdfYnOFHxs4JmlROwiJAAtwfHU9iNhCjKSPtctcKGF3Ox/CrYpXO
 gI0ATPdaUrXk2QXhtVnK6MBX0Yw/OY4=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae71248 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ISFvD8blF_amzRDVKuIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: FSeW_xBw1AQjvh94xp1_Cv2MmIjc9VKs
X-Proofpoint-ORIG-GUID: FSeW_xBw1AQjvh94xp1_Cv2MmIjc9VKs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX3GM/IUThtHs5
 tr0Z6EH/XG+CBMulxjfWWChGXPx5s1KSWs64nC7GgYYsDuZ3qE6weGWfHlMT1tXu6crTnlI82nY
 Vy6ltIghTWh7iys0ribyNVAdM+SOVaJHPmnqn/FW2DNGdpiwT4Fvz8ljiSsSwVqrSRXbcKB9pO3
 cigAvd0UajsdZREEwahe8bK8HDI6krs4UQA19wwSf8LBMSNdKoOjWx0tEy3HNr0iWvD/PmuU6Zr
 0jIDBznRIcqglCeOlIh0plCoV9Ut4TumuwW0ve78jKjEKZya/VHlfYNFmQ0UbkZL1d4ahds1lw6
 KQW0+azOPrVajLYvEA5ljX96ryZT0JJA+bSF+YeR9CcNqaqt3YqIoOw89vw3Hu5Jkt/8O0DROcg
 OTtOQN0w6/iRuE2KxBxmRLjBl0cHzKpSs8x7plNhA+Pep1pNVuvrB21KxNhGJt3iAOzyVsESsHx
 SdE1qG0D7d3H8r4hZEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
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

Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
platforms. This config automatically selects the required dependencies
for Snagboot mode.

Add QCOM_BOOT0_SNAGBOOT_MODE as a hidden boot0.h config, selected
automatically by QCOM_SNAGBOOT_MODE. This boot0.h config is for
disabling MMU at the start of U-Boot execution.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v10:
- Depend on ENV_IS_DEFAULT instead of selecting ENV_IS_NOWHERE and
  depending on !ENV_IS_IN_SCSI
- Drop depends on COUNTER_FREQUENCY != 0
- Drop depends on TEXT_BASE != 0x0
- Drop depends on !PSCI_RESET and !SAVE_PREV_BL_INITRAMFS_START_ADDR

Changes in v9:
- Remove depends on !IOMMU from QCOM_SNAGBOOT_MODE

Changes in v7:
- No changes

Changes in v5:
- Made QCOM_BOOT0_SNAGBOOT_MODE dependent on QCOM_SNAGBOOT_MODE so
  it is not exposed to users
- Add dependencies for QCOM_SNAGBOOT_MODE explicitly as "depends"

Changes in v4:
- Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
- Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
  QCOM_SNAGBOOT_MODE
- Document the platform-specific requirements and configs that must be
  disabled in snagboot mode.

Changes in v3:
- Newly introduced in v3
---
 arch/arm/mach-snapdragon/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 2c182c7b974..2c6fd78a186 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -90,4 +90,18 @@ config QCOM_EL2_GUNYAH_EXIT_SUPPORT
 
 endchoice
 
+config QCOM_BOOT0_SNAGBOOT_MODE
+	bool
+	depends on QCOM_SNAGBOOT_MODE
+
+config QCOM_SNAGBOOT_MODE
+	bool "Build U-Boot for Snagboot mode loading"
+	select QCOM_BOOT0_SNAGBOOT_MODE
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SKIP_RELOCATE
+	depends on ENV_IS_DEFAULT
+	help
+	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
+	  for device/factory provisioning using fastboot.
+
 endif

-- 
2.34.1

