Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04F606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SHPAAtST;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cL8EvEk3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bhlvMbKq
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F33860830;
	Tue,  3 Nov 2026 13:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EScATBHP4x8y; Tue,  3 Nov 2026 13:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE81D6080C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793713453;
	b=bNmlwzY+bWQZiIK+zf6f4OxGrhm2T5yy6zl7egqoLyNPwTW0hwkSoiLaWRhxQLc9m2G3
	 WAqafVLswQ3E6q97g5cTlHvWfXFsJ1RaaZ++E+fD+LHeMvOjsAYDH8AIcSrp2VWjT0UKJ
	 gQfv/hlU75Oru7Pggi1In43PeRcGekyL+/v0v/TDY7Szm0bU7L3Ac9LvJtTt8xyxwXJOg
	 E8dLfBDURi8Ew69ygQFUPK5kKR/Omu+WnCHpevwEWlPGX6ulSAyKbqPMtyrzouAY+zm/H
	 JUE0gjR8AiqOa+4F1HnBBr7T4lRJjZu2Flm5cCGyf0tNHoqSnCkSVGVwReu2AfH09Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793713453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
	b=covSG30uKe94j3/sl5yRzhCJy0mhRPtb1kXRqoXTo7lcccJXEEj9Gt4wx1GIxbMfw69k
	 G2o5l4SzZ0rIQcmZzKCWw7B+ZuKKDP+uB2HvSx8aq11BENmMLBVL2whbKyO0/fpkEWBH/
	 Qr8eWjOInp7JFXU1nSGIgzi5CWNBwBb5u6XB9pKPwDC0WP5bC1bfvF2bqT5UgwnM9KqHt
	 +Tomnc2pZvBq+bR4vnYlVzn1PozztwIjTeLV6IDaSCvD/a9/QbltPL5EsBK7f9N/3YqYj
	 7EM4haREpDrx4G9qNigW2u+bPTA+m2U/Y3lTURwEUgxQ5Mvw8L3juJvkGPDhAjaliuw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cL8EvEk3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bhlvMbKq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793713453;
	bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SHPAAtSTPzZTaP53405+W/PNjrXNJmVL8OjS2kCkLvPzLLhT99eE+0+UWGljmVNp6
	 t+F3pdbleRXuuHMfj/xGG9Faz30VsgumoJabVgwcozqtpI2G5R81fyImfJ6pgOcB4d
	 kUrRT/PhNqONgSsEyKOl/VfF88y8ijWt9AavTIrE2UmppeWbCYonbXE0yVHoX0NFmO
	 L7QvQNZn58a5Iw/8LkDpbMZy0wIhHEkvBBDvvGqeUVKIQUX09YSD8Vl0ztd966I4XL
	 o+bhmzGj0Z3OZulL29hhYsPz4sV5i5Oth2ZKaYDH3L0lb4h2FVGhFl6l0joIvHTREr
	 FuWSzQJchwIQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE81D6080C;
	Tue,  3 Nov 2026 13:44:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DDE75D3A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1D7F606DE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDQY9AAfUnlt for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 13:44:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60F016080C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793713450;
 b=YlcLyyTu2U2hPrz4EuQYwKbDI7BSHPO/kFamlSKqY6HlRmJsGXAkb2Byc1f4NkJx8dOg
 Y4mTZRA5F66je4SOiFsSsFFk2UG4OiifZxzqbcchAHHVlw5hQ6yJwFTmQ0nRdNN+aEoYb
 kC/MWjQzvmsZGuiAi/NI0X4I7hAVooKlc9D3sKDfldWVrt5klrrhtojIv9F5ryHujf80s
 z+7zFYy2a9ueeV5BDkrlKk8QdXA9JOkRRqu2s/7jrnHNSYo3X75iAglNZnZ4t21iG8cQT
 zEjOVu50yHFnulFI2ucpspH+/O3jwAW6oY1QVQwWVspKZo3I57RxAPYxQkYnI6au/6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793713450;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
 b=cOcCR0uu4uXqfTtuRIfLE6LsaERkScvwRL5MKjeDIW/hb5RMLLinM6lc20nhNtEApnj6
 NITCME0ppdrdhWAEwJJ4yoLCk2E3MNzG0Y1AX8RTCdBlH/xa/LE3pEbXNMFdryK01lJuC
 j9NaViCVMGhSV3d2HR6Tj+UxPTir6vcOA/07PPyus6F/gJJV9083KmVx7pqChSfqtux3L
 4m+LxkvuWBjskarsTZB2olMyECVwyK2FBMtR599cto7GoFnhHfTXX2bsEiQBNK0YMYhN3
 3Y7KwM0Q77zwxxFZM4qJlNgbYWBHjP5YrnPjis4svgvSUNyU0/VTlvaZDNPLlfPDsLw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=cL8EvEk3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bhlvMbKq; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cL8EvEk3; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bhlvMbKq
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60F016080C
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 13:44:09 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3DZ7uE3973628
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 13:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IbHO5Px37rh
 kdumqN31GteBLcsg3CBdTgzZS4DyAFso=; b=cL8EvEk3RAMwlGfTcAeAI/b08WZ
 SsnqgYIdLNNECc3i+Ys/U15lPHRpQqw5VVszF1NaYUqvhxF/d9Aq3hKSrGdU275l
 iTazp5yobUdHseKza+QWBCSIBoJoxNhdRuN56FL+162BEaVR4XgUHHJB8mFYxmhc
 t6unfS1hqsLT5Q4pg1YUwkdmwd8pjrV0ylRcftUFfzVBanM1Y74ipv/UeOhhvCjB
 swinvpUU0vsWTCMekxpJb5aVJ/RqbZMiSjd5HV/Zbkn0L3SF59OjNKmnl2CWdYzO
 ZA5S7O+HOFh9IXpPcMzHA4Xiiqfkw4ui8dYwbV8aAemvLoXQVm7zEEj9C3w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy33md-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:44:09 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so9460517c88.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793713448; x=1794318248;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
 b=bhlvMbKqW8ZpXswmOtns027qLGcJF2erdv1+s3cmm5WpMbyb9eewKKoT5dgKFjjEla
 VRZW+85iyEuS0atU3AzfXEFoAWI1eIHx/y8MUp8r5zNTu+b/h9nrNdZE5AOkR47kYevS
 krDtvKskXdzTESsJchEbCTgBiPAuNyOyd9aN+krpc4FUnXk6hRb6NVF9uPzD4MCe5j/x
 yN+Y227AxnBzmbLEdi6unHafz+60qEuPpBWij3/hvR7PBJqtpEUN43kTQaRLQsIJ+kS2
 VBHlrWMUNdEe37N4JXyW7YDrMvbv+RvW0pYaIDC8q90imLpYCsmOI1lLGhZv511DJIuU
 Mu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713448; x=1794318248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IbHO5Px37rhkdumqN31GteBLcsg3CBdTgzZS4DyAFso=;
 b=SJy4hxjTpM/Fx7QV+OdwZgQw6alARHlmcL5HXGl5FFcb7OTCtjBCV0trqAk1O7ASv3
 CVTuaypi3RjGYGAtJ0WhrM4ZhKMoBYg/+dcOWhi6gY0OhUZ6nLq/xm+T22bdAeF0p1UF
 bDhNciDPMBPAB6OxODd+fcgTYOi93vqYBp/v6mAWV6PoATFcmVA16s20H7AEdtr5t2tp
 0A5aat6IVrjyz1NJeNZMD9bUFGS2TJ8zSTFuQqIICBU32e9Y3UqaJtqyziYKdv44YxJ2
 gXdoclxXY1IOoh/xorkq/9ukHX35rbT4ldac7mjgYvdmQuxxhDQM7kujn6AtUNbIDt29
 W39g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzryfte5UOrE9yDZFH1rShRAR3pbGHj/vjsDKD434MZ/WIk5I8fmStXZAfQk97UfOmKyCZ501o=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8nAfew0NupYmWSNX5OX3XqYXOxV5+lLDNHoqOVxzN97LQ/cB+7
 QX0Bp9R1KmzssmVHkLcSh7sKLyL1/+DNzmUZsn4uXNOPOTIqpvXkGukZkFJoAR4FdXCgotabYWw
 yW3pVibp+GK/yscd/k5pZr3475tP6ljb2B8xlHhRXbEuJUCQBvzeheJvC/rBqVNkpbiZEXAE=
X-Gm-Gg: AYBFou1y2mO23xpR2pqVLoPc+27neBd4zGb3m9zzUzc3pZno9Wtb2ul04j/24RJFl/b
 /2NFhPt1o0fxRHAMc0hBi0cw2FC2FQB9sVBqrSgieyU/x+LzbJpH+N5nFhgQQrFYYEzAkKUwMaB
 gcgol/YztyErleralHa7zHf20rV/S6PaEUaOGlG0NeuzaWmdJDdaEVnDTgoR4VP8e4odLT2zdyZ
 GclQhnhg9/v7b8IscefcABXirlx0vxjr8CZ1kYqK2PeMof7E3H3TiY2lAHBgi7ueFYGIy02KQcD
 xhWBRBQn9no1ubZUs3PrgTPnzYS2Ji9fJBcWwxwKRuoy74ad6VLr4FrcKwd+nBTeEjySvDfEVrV
 qY4ho4jBazf/yUSiTwROGkvl9jXtKPtM7Gw1xpLTt3LbWed4144JeRlmSChUgHYlfiHZpVZ+E8G
 izDJHNnFi2eiPuH1Bvb8Gy3JlI9ekXRYGTvkrHwPZGuNqi0zkrIP/3QYQ6YlOOQrV3U2gT
X-Received: by 2002:a05:7023:d0b:b0:1a7:216d:157c with SMTP id
 a92af1059eb24-1ac5de5380emr21507150c88.34.1793713448259; 
 Tue, 03 Nov 2026 05:44:08 -0800 (PST)
X-Received: by 2002:a05:7023:d0b:b0:1a7:216d:157c with SMTP id
 a92af1059eb24-1ac5de5380emr21507096c88.34.1793713447583; 
 Tue, 03 Nov 2026 05:44:07 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b23f20d36csm7511194c88.11.2026.11.03.05.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:44:07 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 marek.vasut+usb@mailbox.org, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, william.bright@imd-tec.com,
 nikroks@mainlining.org, anshuld@ti.com, jbx6244@gmail.com,
 dlechner@baylibre.com, nathbappai@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v5 1/9] clk: qcom: add GCC clock driver support for shikra SoC
Date: Tue,  3 Nov 2026 19:13:43 +0530
Message-Id: <20261103134351.3532864-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
References: <20261103134351.3532864-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qlVDn5BEGJUMs3MRpVcGdNk_S6hz3ebq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX7q2Vn/BxIYSh
 B4t/NvW+whTG8U9JjRvziZhrGxlW9Py1gsGZW7hYwfpVXVMNvepv2C2/sLh/ygHPhsV/2glnBDe
 DO04bxrT9cFMQyQbHkBd44UHtP4dsZgBAHgwXeU4oRf5cRicmcIde81D6ZL9YZ6UJJjhmQ1YyW1
 J9uUyDBg9xm6sBuuGnMDD6adZ5pGnYBHALWA/YzccyAB4uzEcnRZPL64d6Cbh6SLRAeW9pD9kLD
 Xl9a4z+PUyXLg30lowxPAhtg3GENXDXF2GVA2079gWzoYYAMcdyOCekuyRsQiis+sHLvZ84fCAl
 1dG1wtvvV2BJoaKT4Mek+TFfiqOJXquFXgxVcCXfSpAeXabUZRFVzkRkoOQzlympxINfhDUvDa7
 fRyuYKElGRmGnOw4OvkhE++9yNGkipqtMYBBQ8hPqqgNP2NO8lLtn2Kj4nYzNS6YV0koNvMUjml
 TWzzH+7i9s7xfRrsdFA==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6ae9e529 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=p3-4Csf5Jppavy1jNJYA:9 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qlVDn5BEGJUMs3MRpVcGdNk_S6hz3ebq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX26O36SWH/dJl
 lJNPUTLYETDGjGgQEneNdInJbQhkteQIOlyY19QVov2cqh6J6zdNiCBnRQQmaFyH+e6CMxdGuiv
 9JAkasyI6cheFU8/4h45fAg5YM6hsrA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030054
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

Add initial support for the Global Clock Controller (GCC) on
Qualcomm Shikra SoC.

This introduces a new clock driver (clock-shikra.c) implementing
the required clocks for early boot and peripheral enablement.
Update Kconfig and Makefile to include the Shikra GCC clock
driver in the build.

The driver currently provides basic clock definitions required
for system initialization.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig        |   8 +
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/clock-shikra.c | 344 ++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-shikra.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0d8f5028a4e..2ff0d8c99b3 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -113,6 +113,14 @@ config CLK_QCOM_SDM845
 	  on the Snapdragon 845 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_SHIKRA
+	bool "Qualcomm Shikra GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Shikra SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_SM6115
 	bool "Qualcomm SM6115 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 73cafc3f938..11d6c85af3f 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_CLK_QCOM_RPMH) += clock-rpmh.o
 obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
 obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
 obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
 obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
 obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
new file mode 100644
index 00000000000..edf001d81a1
--- /dev/null
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,shikra-gcc.h>
+#include "clock-qcom.h"
+
+#define GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR	0x1f148
+#define GCC_SDCC1_APPS_CLK_CMD_RCGR		0x38028
+#define GCC_SDCC2_APPS_CLK_CMD_RCGR		0x1e00c
+#define GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR	0x1a01c
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1a034
+#define GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR	0x1a060
+
+static const struct pll_vote_clk gpll6_vote_clk = {
+	.status = 0x6024,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(6),
+};
+
+static const struct pll_vote_clk gpll7_vote_clk = {
+	.status = 0x7024,
+	.status_bit = BIT(31),
+	.ena_vote = 0x79000,
+	.vote_bit = BIT(7),
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_AUX2, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_AUX2, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_AUX2, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 25),
+	F(64000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_AUX2, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(102400000, CFG_CLK_SRC_GPLL0_AUX2, 1, 128, 375),
+	F(112000000, CFG_CLK_SRC_GPLL0_AUX2, 1, 28, 75),
+	F(117964800, CFG_CLK_SRC_GPLL0_AUX2, 1, 6144, 15625),
+	F(120000000, CFG_CLK_SRC_GPLL0_AUX2, 2.5, 0, 0),
+	F(128000000, CFG_CLK_SRC_GPLL6, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_AUX2, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(25000000, CFG_CLK_SRC_GPLL0_AUX2, 12, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_AUX2, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_AUX2, 3, 0, 0),
+	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_AUX2, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static ulong shikra_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S0_CLK:
+		/*
+		 * ftbl_gcc_qupv3_wrap0_s0_clk_src[]'s last entry is
+		 * GPLL6-sourced; vote defensively even though this port's
+		 * only requested rate (debug_uart_clock, 14745600) resolves
+		 * to the GPLL0-sourced entry.
+		 */
+		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_QUPV3_WRAP0_S0_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_SDCC1_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll6_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		clk_rcg_set_rate(priv->base, GCC_USB3_PRIM_PHY_AUX_CLK_CMD_RCGR,
+				 0, CFG_CLK_SRC_CXO);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		WARN(rate != 19200000,
+		     "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, GCC_USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				 0, CFG_CLK_SRC_CXO);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk shikra_clks[] = {
+	GATE_CLK(GCC_AHB2PHY_CSI_CLK, 0x1d004, BIT(0)),
+	GATE_CLK_POLLED(GCC_AHB2PHY_USB_CLK, 0x1d008, BIT(0), 0x1d008),
+	GATE_CLK_POLLED(GCC_BOOT_ROM_AHB_CLK, 0x7900c, BIT(1), 0x23004),
+	GATE_CLK_POLLED(GCC_CAMSS_AXI_CLK, 0x58044, BIT(0), 0x58044),
+	GATE_CLK(GCC_CAMSS_CAMNOC_ATB_CLK, 0x5804c, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAMSS_CAMNOC_DRAGONLINK_ATB_CLK, 0x58060, BIT(0), 0x58060),
+	GATE_CLK(GCC_CAMSS_CAMNOC_NTS_XO_CLK, 0x58050, BIT(0)),
+	GATE_CLK_POLLED(GCC_CAMSS_CCI_0_CLK, 0x56018, BIT(0), 0x56018),
+	GATE_CLK_POLLED(GCC_CAMSS_CPHY_0_CLK, 0x52088, BIT(0), 0x52088),
+	GATE_CLK_POLLED(GCC_CAMSS_CPHY_1_CLK, 0x5208c, BIT(0), 0x5208c),
+	GATE_CLK_POLLED(GCC_CAMSS_CSI0PHYTIMER_CLK, 0x45018, BIT(0), 0x45018),
+	GATE_CLK_POLLED(GCC_CAMSS_CSI1PHYTIMER_CLK, 0x45034, BIT(0), 0x45034),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK0_CLK, 0x51018, BIT(0), 0x51018),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK1_CLK, 0x51034, BIT(0), 0x51034),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK2_CLK, 0x51050, BIT(0), 0x51050),
+	GATE_CLK_POLLED(GCC_CAMSS_MCLK3_CLK, 0x5106c, BIT(0), 0x5106c),
+	GATE_CLK_POLLED(GCC_CAMSS_NRT_AXI_CLK, 0x58054, BIT(0), 0x58054),
+	GATE_CLK_POLLED(GCC_CAMSS_OPE_AHB_CLK, 0x5503c, BIT(0), 0x5503c),
+	GATE_CLK_POLLED(GCC_CAMSS_OPE_CLK, 0x5501c, BIT(0), 0x5501c),
+	GATE_CLK_POLLED(GCC_CAMSS_RT_AXI_CLK, 0x5805c, BIT(0), 0x5805c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_0_CLK, 0x5201c, BIT(0), 0x5201c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_0_CPHY_RX_CLK, 0x5207c, BIT(0), 0x5207c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_0_CSID_CLK, 0x520ac, BIT(0), 0x520ac),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_1_CLK, 0x5203c, BIT(0), 0x5203c),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_1_CPHY_RX_CLK, 0x52080, BIT(0), 0x52080),
+	GATE_CLK_POLLED(GCC_CAMSS_TFE_1_CSID_CLK, 0x520cc, BIT(0), 0x520cc),
+	GATE_CLK_POLLED(GCC_CAMSS_TOP_AHB_CLK, 0x58028, BIT(0), 0x58028),
+	GATE_CLK_POLLED(GCC_CAM_THROTTLE_NRT_CLK, 0x79004, BIT(16), 0x17070),
+	GATE_CLK_POLLED(GCC_CAM_THROTTLE_RT_CLK, 0x79004, BIT(15), 0x1706c),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x111c4, BIT(0), 0x111c4),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x1a07c, BIT(0), 0x1a07c),
+	GATE_CLK(GCC_DDRSS_GPU_AXI_CLK, 0x71000, BIT(0)),
+	GATE_CLK_POLLED(GCC_DDRSS_MEMNOC_PCIE_SF_CLK, 0x29044, BIT(0), 0x29044),
+	GATE_CLK(GCC_DISP_GPLL0_DIV_CLK_SRC, 0x79004, BIT(11)),
+	GATE_CLK_POLLED(GCC_DISP_HF_AXI_CLK, 0x17020, BIT(0), 0x17020),
+	GATE_CLK_POLLED(GCC_DISP_THROTTLE_CORE_CLK, 0x79004, BIT(13), 0x17064),
+	GATE_CLK_POLLED(GCC_EMAC0_AHB_CLK, 0xad010, BIT(0), 0xad010),
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_CLK, 0xad014, BIT(0), 0xad014),
+	GATE_CLK_POLLED(GCC_EMAC0_AXI_SYS_NOC_CLK, 0x109d4, BIT(0), 0x109d4),
+	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_RX_CLK, 0xad044, BIT(0)),
+	GATE_CLK(GCC_EMAC0_CC_SGMIIPHY_TX_CLK, 0xad03c, BIT(0)),
+	GATE_CLK_POLLED(GCC_EMAC0_PHY_AUX_CLK, 0xad018, BIT(0), 0xad018),
+	GATE_CLK_POLLED(GCC_EMAC0_PTP_CLK, 0xad034, BIT(0), 0xad034),
+	GATE_CLK_POLLED(GCC_EMAC0_RGMII_CLK, 0xad038, BIT(0), 0xad038),
+	GATE_CLK_POLLED(GCC_EMAC1_AHB_CLK, 0xae010, BIT(0), 0xae010),
+	GATE_CLK_POLLED(GCC_EMAC1_AXI_CLK, 0xae014, BIT(0), 0xae014),
+	GATE_CLK_POLLED(GCC_EMAC1_AXI_SYS_NOC_CLK, 0x109f4, BIT(0), 0x109f4),
+	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_RX_CLK, 0xae044, BIT(0)),
+	GATE_CLK(GCC_EMAC1_CC_SGMIIPHY_TX_CLK, 0xae03c, BIT(0)),
+	GATE_CLK_POLLED(GCC_EMAC1_PHY_AUX_CLK, 0xae018, BIT(0), 0xae018),
+	GATE_CLK_POLLED(GCC_EMAC1_PTP_CLK, 0xae034, BIT(0), 0xae034),
+	GATE_CLK_POLLED(GCC_EMAC1_RGMII_CLK, 0xae038, BIT(0), 0xae038),
+	GATE_CLK_POLLED(GCC_GP1_CLK, 0x4d000, BIT(0), 0x4d000),
+	GATE_CLK_POLLED(GCC_GP2_CLK, 0x4e000, BIT(0), 0x4e000),
+	GATE_CLK_POLLED(GCC_GP3_CLK, 0x4f000, BIT(0), 0x4f000),
+	GATE_CLK(GCC_GPU_GPLL0_CLK_SRC, 0x7900c, BIT(18)),
+	GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC, 0x7900c, BIT(19)),
+	GATE_CLK_POLLED(GCC_GPU_MEMNOC_GFX_CLK, 0x3600c, BIT(0), 0x3600c),
+	GATE_CLK_POLLED(GCC_GPU_SMMU_VOTE_CLK, 0x7d000, BIT(0), 0x7d000),
+	GATE_CLK_POLLED(GCC_GPU_SNOC_DVM_GFX_CLK, 0x36018, BIT(0), 0x36018),
+	GATE_CLK_POLLED(GCC_GPU_THROTTLE_CORE_CLK, 0x7900c, BIT(21), 0x36048),
+	GATE_CLK_POLLED(GCC_MMU_TCU_VOTE_CLK, 0x7d06c, BIT(0), 0x7d06c),
+	GATE_CLK_POLLED(GCC_PCIE_AUX_CLK, 0x79018, BIT(0), 0xaf044),
+	GATE_CLK_POLLED(GCC_PCIE_CFG_AHB_CLK, 0x7900c, BIT(27), 0xaf010),
+	GATE_CLK(GCC_PCIE_CLKREF_EN, 0xb8000, BIT(0)),
+	GATE_CLK_POLLED(GCC_PCIE_MSTR_AXI_CLK, 0x7900c, BIT(30), 0xaf020),
+	GATE_CLK_POLLED(GCC_PCIE_PIPE_CLK, 0x79018, BIT(2), 0xaf050),
+	GATE_CLK_POLLED(GCC_PCIE_RCHNG_PHY_CLK, 0x7900c, BIT(31), 0xaf040),
+	GATE_CLK_POLLED(GCC_PCIE_SLEEP_CLK, 0x79018, BIT(1), 0xaf04c),
+	GATE_CLK_POLLED(GCC_PCIE_SLV_AXI_CLK, 0x7900c, BIT(29), 0xaf018),
+	GATE_CLK_POLLED(GCC_PCIE_SLV_Q2A_AXI_CLK, 0x7900c, BIT(28), 0xaf014),
+	GATE_CLK_POLLED(GCC_PCIE_TBU_CLK, 0x79018, BIT(6), 0xaf098),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_CORE_CLK, 0x79018, BIT(5), 0xaf094),
+	GATE_CLK_POLLED(GCC_PCIE_THROTTLE_XO_CLK, 0x79018, BIT(4), 0xaf090),
+	GATE_CLK_POLLED(GCC_PCIE_TILE_AXI_SYS_NOC_CLK, 0x10f2c, BIT(0), 0x10f2c),
+	GATE_CLK_POLLED(GCC_PDM2_CLK, 0x2000c, BIT(0), 0x2000c),
+	GATE_CLK_POLLED(GCC_PDM_AHB_CLK, 0x20004, BIT(0), 0x20004),
+	GATE_CLK_POLLED(GCC_PDM_XO4_CLK, 0x20008, BIT(0), 0x20008),
+	GATE_CLK_POLLED(GCC_PWM0_XO512_CLK, 0x2002c, BIT(0), 0x2002c),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x79004, BIT(9), 0x17014),
+	GATE_CLK_POLLED(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x79004, BIT(12), 0x17060),
+	GATE_CLK_POLLED(GCC_QMIP_DISP_AHB_CLK, 0x79004, BIT(10), 0x17018),
+	GATE_CLK_POLLED(GCC_QMIP_GPU_CFG_AHB_CLK, 0x7900c, BIT(20), 0x36040),
+	GATE_CLK_POLLED(GCC_QMIP_PCIE_CFG_AHB_CLK, 0x79018, BIT(3), 0xaf08c),
+	GATE_CLK_POLLED(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x79004, BIT(8), 0x17010),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x79004, BIT(21), 0x1f014),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_CORE_CLK, 0x79004, BIT(20), 0x1f00c),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S0_CLK, 0x79004, BIT(22), 0x1f144),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S1_CLK, 0x79004, BIT(23), 0x1f274),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S2_CLK, 0x79004, BIT(24), 0x1f3a4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S3_CLK, 0x79004, BIT(25), 0x1f4d4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S4_CLK, 0x79004, BIT(26), 0x1f604),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S5_CLK, 0x79004, BIT(27), 0x1f734),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S6_CLK, 0x79004, BIT(28), 0x1f864),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S7_CLK, 0x79004, BIT(29), 0x1f994),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S8_CLK, 0x79004, BIT(30), 0x1fac4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP0_S9_CLK, 0x79004, BIT(31), 0x1fbf4),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x79004, BIT(18), 0x1f004),
+	GATE_CLK_POLLED(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x79004, BIT(19), 0x1f008),
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK, 0x38008, BIT(0), 0x38008),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK, 0x38004, BIT(0), 0x38004),
+	GATE_CLK_POLLED(GCC_SDCC1_ICE_CORE_CLK, 0x3800c, BIT(0), 0x3800c),
+	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK, 0x1e008, BIT(0), 0x1e008),
+	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK, 0x1e004, BIT(0), 0x1e004),
+	GATE_CLK_POLLED(GCC_SYS_NOC_USB2_PRIM_AXI_CLK, 0x10a14, BIT(0), 0x10a14),
+	GATE_CLK_POLLED(GCC_SYS_NOC_USB3_PRIM_AXI_CLK, 0x1a078, BIT(0), 0x1a078),
+	GATE_CLK_POLLED(GCC_TSCSS_AHB_CLK, 0xac024, BIT(0), 0xac024),
+	GATE_CLK_POLLED(GCC_TSCSS_CNTR_CLK, 0xac020, BIT(0), 0xac020),
+	GATE_CLK_POLLED(GCC_TSCSS_ETU_CLK, 0xac01c, BIT(0), 0xac01c),
+	GATE_CLK(GCC_UFS_CLKREF_EN, 0x8c000, BIT(0)),
+	GATE_CLK_POLLED(GCC_USB20_MASTER_CLK, 0xb0010, BIT(0), 0xb0010),
+	GATE_CLK_POLLED(GCC_USB20_MOCK_UTMI_CLK, 0xb001c, BIT(0), 0xb001c),
+	GATE_CLK_POLLED(GCC_USB20_SLEEP_CLK, 0xb0018, BIT(0), 0xb0018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MASTER_CLK, 0x1a010, BIT(0), 0x1a010),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1a018, BIT(0), 0x1a018),
+	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1a014, BIT(0), 0x1a014),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_EN, 0x9f000, BIT(0)),
+	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1a054, BIT(0), 0x1a054),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1a058, BIT(0)),
+	GATE_CLK_POLLED(GCC_VCODEC0_AXI_CLK, 0x6e008, BIT(0), 0x6e008),
+	GATE_CLK_POLLED(GCC_VENUS_AHB_CLK, 0x6e010, BIT(0), 0x6e010),
+	GATE_CLK_POLLED(GCC_VENUS_CTL_AXI_CLK, 0x6e004, BIT(0), 0x6e004),
+	GATE_CLK_POLLED(GCC_VIDEO_AXI0_CLK, 0x1701c, BIT(0), 0x1701c),
+	GATE_CLK_POLLED(GCC_VIDEO_THROTTLE_CORE_CLK, 0x79004, BIT(14), 0x17068),
+	GATE_CLK(GCC_VIDEO_VCODEC0_SYS_CLK, 0x6d044, BIT(0)),
+	GATE_CLK_POLLED(GCC_VIDEO_VENUS_CTL_CLK, 0x6d02c, BIT(0), 0x6d02c),
+};
+
+static int shikra_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (priv->data->num_clks < clk->id) {
+		debug("%s: unknown clk id %lu\n", __func__, clk->id);
+		return 0;
+	}
+
+	debug("%s: clk %ld: %s\n", __func__, clk->id, shikra_clks[clk->id].name);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map shikra_gcc_resets[] = {
+	[GCC_CAMSS_OPE_BCR] = { 0x55000 },
+	[GCC_CAMSS_TFE_BCR] = { 0x52000 },
+	[GCC_CAMSS_TOP_BCR] = { 0x58000 },
+	[GCC_EMAC0_BCR] = { 0xad000 },
+	[GCC_EMAC1_BCR] = { 0xae000 },
+	[GCC_GPU_BCR] = { 0x36000 },
+	[GCC_MMSS_BCR] = { 0x17000 },
+	[GCC_PCIE_BCR] = { 0xaf000 },
+	[GCC_PCIE_PHY_BCR] = { 0xb1000 },
+	[GCC_PDM_BCR] = { 0x20000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x1f000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x1c000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x1c004 },
+	[GCC_SDCC1_BCR] = { 0x38000 },
+	[GCC_SDCC2_BCR] = { 0x1e000 },
+	[GCC_TSCSS_BCR] = { 0xac000 },
+	[GCC_USB20_BCR] = { 0xb0000 },
+	[GCC_USB30_PRIM_BCR] = { 0x1a000 },
+	[GCC_USB3PHY_PHY_PRIM_SP0_BCR] = { 0x1b008 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x1b020 },
+	[GCC_USB3_PHY_PRIM_SP0_BCR] = { 0x1b000 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x1d000 },
+	[GCC_VCODEC0_BCR] = { 0x6d034 },
+	[GCC_VENUS_BCR] = { 0x6d018 },
+	[GCC_VIDEO_INTERFACE_BCR] = { 0x6e000 },
+};
+
+static const struct qcom_power_map shikra_gdscs[] = {
+	[GCC_CAMSS_TOP_GDSC] = { 0x58004 },
+	[GCC_EMAC0_GDSC] = { 0xad004 },
+	[GCC_EMAC1_GDSC] = { 0xae004 },
+	[GCC_PCIE_GDSC] = { 0xaf004 },
+	[GCC_USB20_GDSC] = { 0xb0004 },
+	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
+	[GCC_VCODEC0_GDSC] = { 0x6d038 },
+	[GCC_VENUS_GDSC] = { 0x6d01c },
+};
+
+static struct msm_clk_data shikra_gcc_data = {
+	.resets = shikra_gcc_resets,
+	.num_resets = ARRAY_SIZE(shikra_gcc_resets),
+	.clks = shikra_clks,
+	.num_clks = ARRAY_SIZE(shikra_clks),
+
+	.power_domains = shikra_gdscs,
+	.num_power_domains = ARRAY_SIZE(shikra_gdscs),
+
+	.enable = shikra_enable,
+	.set_rate = shikra_set_rate,
+};
+
+static const struct udevice_id gcc_shikra_of_match[] = {
+	{
+		.compatible = "qcom,shikra-gcc",
+		.data = (ulong)&shikra_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_shikra) = {
+	.name		= "gcc_shikra",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_shikra_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

