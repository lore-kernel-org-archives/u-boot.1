Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B21DCA600E
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA2B3811E8;
	Thu,  8 Oct 2026 09:49:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byMEKQHJPkf3; Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7C7D4811E3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452965;
	b=Tau2J/UudJI/U83g9Hce4+a4/LbDK4pARmLy5O9WD0OUy/ac3w5rpdWgKdxHsgHWK0h5
	 8HohjYKQfwCGEJUZrUP9/PkFgqxga6LiPG/BdvMbew97DOGb13VcoQyVuxo5iiTUsloAG
	 8Yy9IU4sdhq3GeWvFnK2XWczARXX8qHmm1e1C8WJDQqOYx0nrZYorISVFx6ErDCQvd9DR
	 d+jzD49bXAzZksxpfvVqY6P4vEQ8qECU2Qwv2YIizyOgiwGbsfFDZJYk3OkeFPIgP2pSJ
	 CbaOkjGcHDqk7tJ9skdabzBvhv8MegfMguH9ckW7unDDLbG+LQeLXiPVWhnW4Bc0pyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452965;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
	b=sXNyZQ71oTJBbFe6c6f1Wbr4warYt3m5d4So3of7H2H3yYtzKX/xVNoIBotmPb1FGXME
	 DRJuR/8wS54wMQ0DnW3lCeFFIQRTr2isxdi1W2E5/k5Ct8noYWPHIJ5PkpGosxwpdAAAB
	 RmeD+DpjM7ZPW8Rq6l9PuN25sq7dygrhE+BAvSjAAEGbjAQKKoHlZm1UEt8t5pN54nEgg
	 psPwZwEKcvN4CMVE2jfJv5cqi1iR9tFLxq0SGniI1zMh+TZG1hC205M6NKuu+lkpGajXM
	 iiduoKuM59dMUrUdIa9OYIk97sQJR7o7A/IAky9ByRXWEtx+FIqRyms0iUOB4gW0czA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dhANy6Iz;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="T7WCd/Ak";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452965;
	bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rQLWPw1eFRb6KV7VKHsKC89lZqUgev/U7SX1J/DQ84rzIHctlz9QKpWZ+GgtmoI/9
	 DOjsYqdjU0XGvuZDyOO+olIYVVROM8LYQhDJZerxOYTrVvju8yMHQneWzOWa4yIIWO
	 mOBsKI7W32Tsb233q7BMfPZ2pVYL90+xX7v7hJC44srneMCojgbZs3gbA0qfgQirn3
	 8vqFq65rqCxKWPfWjclMUNJZAztsO4RmMJIPLRC9gBE54fJAC9VeozujY1H6Phz2yD
	 FIgBYOGE8gXt732oB45rdIMxnZPKgIQdagCb60ApwcJKXcwY62DzHin9OoubRksIFS
	 pGDzeIkys1BKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C7D4811E3;
	Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BC7672AA
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9DA6811E3
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIi1AIjqeQtC for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AF1D7811BD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452962;
 b=AQNHGwyHpoSCGt0bK3DFld4jPZ9PPD95yUk1x4ZKw/lBUZYc8GmVi6k5d7G0Y6CmPnj2
 krdyg1rPIdWBu1ZEHqM0QJp2AkVCDUV5wj1nP7CW0yXzPkYu1J3FxHe1Dk4AdQy2CAZR6
 PYwC6rHV5Z7UbA7m9NI6oDoAkd6FT3VuAHzucJmiyo2RB5deX/dUq5p80lnUMLmHjO7hu
 aaQUKRyt041WcWEitRkw4n+WZe31jZkO82AI6OJc/BEgHMjWIY6E8/pKhXtfLmdJOcemx
 G08UFxpMMLJymTPLNHUB7ZphEzblYJxtr2MAXqVFR74KA+X9WZdZ0ir2zqOV9QxCjWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452962;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
 b=Q+Qe+iTW3MCO03HsVfCTkSLmVhToJLMpBPMNh/dyMVSrrTIwn5AKvtzf/D7zaF1WwETi
 nDwIFqXjYlYTzqGPg3ZEXkiAzGBUf0pw6kk6yjmPN35p+uH2zjbO5ntv33XQeAT5ynhjH
 HJXIKTIfsn7CMZ4OFOdriFlkjvLXlLUroyCXFVQSinqzPsm8YB7jBHSXKwkrgfxEIF42K
 Iuf7J4x9tUckcHaYYZqkB7+4YAJsNa0cpjlFNfUHAQVJFqHnJoixc5Dc9yHttXVgr6+Ky
 PdAAAAMMQxmzLw+h7V82q1oZMgum70gw0q4m7n41YGLwslWRgOz8e88+U2p3i7nuPkQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dhANy6Iz; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="T7WCd/Ak"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dhANy6Iz; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=T7WCd/Ak
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF1D7811BD
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:22 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K1bo1341626
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTw
 nkN/Pv5k=; b=dhANy6Iz4zPp0DBoMLxZVZ/2eV8nzXdCeeDBNM8d+Z3cmqAtkpp
 2t2xyqtnvBXFG1Q4JIooZfltN/Pxbrd6X7YUstsqCSKA0+jjOk5P8O6bNqWdcOnD
 0V/1/qmSG5hfqlx8RIsrywY4YrpzdDlWHuhSh8dPyEvu5u1v4A+3qXRCVpJ/4fdM
 jROqNlhLmHt86LS65/uxw3+zKibWvT3QrPKyTXbql5xB4pdIx17CWFa4HLLHAyV9
 6+kH2qrtkP2o9khZK2f8V9qFNYjMHFsajC4ple2JtNV4Bx3i9le3NuNrnaOZAFrw
 DaQliBBj6Ecnwb5T2ivNBAvSi30u4Ixc8LQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2t9ws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:21 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14fed306427so17041466c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452961; x=1792057761;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
 b=T7WCd/AkMEMq+R2/a/ivdOrsjxad1zNoH6DOO0MExhGoVPTXknGGp9R576fXb2Zler
 NhE4KWlPuKluQrK2HTGQ6ZbBlPx6X+a6m9cfLJc5H3/Dg1dWtoYAGWZtx8sV31SXT/+a
 +MJ4BDhpsP8Ti4nieqGrAJeJzYLNjGXFl+JNc9mrBxlJQ5qFbTnCCrhIIfWsrnt4uQww
 ZanjL5ecpKUxXglQqgkpx14RzQHu4bupOXXvh4++hJSmhau7Z7ls7rncsD9IsVJCK1XY
 e9onlLJDvan1PXdVrEyuVFxQjX1450YC6x+10LLVYZAoKijkpA8NtHsiwtc+ogY54E5l
 poIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452961; x=1792057761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5AiJtkANOsugNwKsD0H+w5jWkfwEMDigYTwnkN/Pv5k=;
 b=qq8u17yCtbyH1gmDizB6MKDp/H1+f2sFq12ZmLOHQ7EGjmE6lg7Dp2LqWCuDegQW68
 EOKrkLO08dCo/XJ6GC+grpfW+KtL/tHNXsopI3Mnc1mrPqJyatFOda5fQLXd6MlemkLd
 dqiH6sfJlQPmlhnFL1dnirMWNTZ09HOlCt2KQ/zkGN7y0sjR2TfV1ykDLEmuRECFnHPm
 pBkbko3q1wlX0TqM/ajgW6AHJp24pUuYFBpJXs+KNNWTJNo9wKjlNrth2sb+/IFEZJl2
 xSX7NjKhJs8Bmyvsr8wgk5XcPvxzeZW7FmDtcH5AshHu7XLnH76bOE7NxJ37TTyWfF21
 fvDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8SHCbEsJ+VCqU1TJvMJvmwLsa87vjpUsPIvT26/tGBDiCZbeGYXr7zLrAYUdDhK7dqZB1qq0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mWdR/hW9KTyDMVX5/H6SuVcbD1pyDuDTaNY9dJPpDIwjTiPpBS
 ofDqgWRx7jkGsAoQb3GdYUsXz+Ykk1lmlkncDYrI8bZxsAMj6ALn2ycyspwKkb3LLxEyOF+2cDH
 8ofnRyq+Mh2Fh69CUNLO6sWNmM26ge+2QA0N6YBIWiOLNZ5CYjXmjyHsU0Tq3mFkLaInrRqU=
X-Gm-Gg: AYBFou3VpcMbeHSVMAeP42sSvLJ0ISHafwEJPZ9zHpI5kMEzt+COPK6JzKBdHoja0LM
 Tz2ag7jMWnwFg9sZ0K/aBThkqovwQMplQAU8qt9YafZVXjxgJWdbQQPZCozcVNyNguP5iAtPhoU
 QyH9G43dXCZAdzjBoOEcnytEY2QwC82I31tTCxL5rFerI17pFa0GvUD5O7Otz/3Q4mW8+yHm0fE
 i0t5g8LCpV2w4144UQUtMf9Fbw1A3wHVT5jZGpc2XHgz58c7DJ78uPaXSvusFbT59rhC5PL/PzG
 sv7Q9wuARiKJHE+Ooet5Ay4hewBT3C5fmQVZKTVMzMI4u0U6++wqGGbn35BrQzDMeegPqVJy8DQ
 uFNBLlkmkjqrOUsgHEkONFVokQxnTSMbod1or+Kq2ZZhwclY=
X-Received: by 2002:a05:7022:28b:20b0:148:8aa2:91cb with SMTP id
 a92af1059eb24-16208809497mr6067822c88.30.1791452960703; 
 Thu, 08 Oct 2026 02:49:20 -0700 (PDT)
X-Received: by 2002:a05:7022:28b:20b0:148:8aa2:91cb with SMTP id
 a92af1059eb24-16208809497mr6067770c88.30.1791452960008; 
 Thu, 08 Oct 2026 02:49:20 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:19 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 00/13] qcom: shikra: add eMMC SPL boot support
Date: Thu,  8 Oct 2026 02:48:59 -0700
Message-Id: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX5VjI3+puWzNO
 /u4W5tzjWksBlDi7BMNLYSe+LdMG4QBgtUQGdeaPTBNjryzH3m3rtAEmCbqrKpj3TzZuBVypnnS
 5zR/a1U4oLSClmH1CiOL0NkLaVYk8mI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX1DyPCIngXBPG
 oy1BOTL5yKUwoWTtEj+avh0KCIQS5biAfDz9unzA9ui+JzrZXUyCG0c+lpQQ7nlUX50z6K9FkWa
 OrPCkhlPr71SKKgxjvOW6QbA9M8b28+B4zWi33iWZn567eylQjiCXV96JcbAMbc8ZADeZ0HmZp9
 w/WkVpHtfovFHu2VwseshnnmhcIuwMY5qll4pPZX8/yUE9kjForkygPwJ4BogNmVngPvRFlLenB
 8nWx50hn6qIqyZ49nJ8LGVSr/RwCmn36XeaxF5r34ow9XRzxK+pdOPMiTS+0Yb1ShML4iZNU9MG
 9UDJIgT+zBPR+1J6B72olR7gdnNEIYl6rgeZrcrGnFEaPmpgKNiGbSGQqLxv1LKn5kXiAEcRtJ4
 nujqv903PIMEH8JpHxOhYYm9yGwFHtiGnlWZJDRi5fP7D+NIhGILrJBdiezq9NS0OXQA0amkrom
 X4UbhoHdfqFoqhCOt6Q==
X-Proofpoint-ORIG-GUID: E89YYrMFaNp4_dI-IS_9Ob_MONbklflO
X-Proofpoint-GUID: E89YYrMFaNp4_dI-IS_9Ob_MONbklflO
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac76721 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=yl49YU_cyvTrWwRhe6cA:9
 a=vBUdepa8ALXHeOFLBtFW:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This series adds U-Boot SPL support for the Qualcomm Shikra platform.

The SPL runs from BOOT_IMEM and performs the early initialization
needed to boot U-Boot from eMMC. It configures the required pinctrl
and clock state, loads QUP firmware from its GPT partition, invokes
QCLIB to initialize DDR, and loads the U-Boot FIT from the eMMC
boot partition.

Dependencies:
 
  This series is based on the following previously posted series:
 
  - Qualcomm IPQ5210 SoC bringup v10, Varadarajan Narayanan (15 patches):
https://lore.kernel.org/u-boot/20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com/
 
  - Initial Shikra SoC support v3, Aswin Murugan (13 patches):
https://marc.info/?l=u-boot&m=178668446732727&w=2
 
  - Enable HS200/HS400 eMMC modes on Qualcomm v2, Aswin Murugan (3 patches):
https://lore.kernel.org/u-boot/20260902170559.3225833-1-aswin.murugan@oss.qualcomm.com/
 

Abhilash V (11):
  arm: qcom: add common QCLIB SPL extension helpers
  pinctrl: qcom: add Shikra SPL pinctrl option
  board: qualcomm: shikra: add SPL board support
  clk: qcom: add configurable FSM-voted PLL helper
  arm: dts: shikra: retain QUP SPL dependencies
  clk: qcom: configure Shikra GPLL6 for SDCC1
  clk: qcom: enable Shikra QUP wrapper clocks
  mmc: msm_sdhci: make tuning callbacks optional
  arm: qcom: enable MMU and cache setup for Shikra SPL
  board: qualcomm: shikra: prepare QUP firmware in SPL
  board: qualcomm: shikra: embed XBL-sec in SPL ELF

Aswin Murugan (2):
  arm: dts: shikra: retain SPL dependencies in IQS overlay
  clk: qcom: build only selected clock drivers in SPL

 arch/arm/dts/shikra-cqs-evk-u-boot.dtsi       |  44 ++
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi       |  42 ++
 arch/arm/mach-snapdragon/Kconfig              |  10 +
 arch/arm/mach-snapdragon/board_spl.c          |  12 +-
 arch/arm/mach-snapdragon/include/mach/qclib.h |  16 +-
 arch/arm/mach-snapdragon/mem_map.c            |  22 +-
 arch/arm/mach-snapdragon/qclib.c              |  77 ++-
 arch/arm/mach-snapdragon/qcom-priv.h          |   4 +
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/config.mk               |  24 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  40 ++
 board/qualcomm/shikra/spl-shikra.c            | 460 ++++++++++++++++++
 drivers/clk/qcom/Kconfig                      | 208 ++++++++
 drivers/clk/qcom/Makefile                     |  48 +-
 drivers/clk/qcom/clock-qcom.c                 |  48 ++
 drivers/clk/qcom/clock-qcom.h                 |  24 +
 drivers/clk/qcom/clock-shikra.c               |  73 ++-
 drivers/mmc/msm_sdhci.c                       |   4 +
 drivers/pinctrl/qcom/Kconfig                  |   8 +
 include/configs/shikra.h                      |  11 +
 20 files changed, 1126 insertions(+), 52 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/config.mk
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

-- 
2.34.1

