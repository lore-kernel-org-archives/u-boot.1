Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oO43gziq;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kvlBa1z1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KCjHriUd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52335407CF;
	Thu, 29 Oct 2026 10:58:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R7-kLS_eAgCF; Thu, 29 Oct 2026 10:58:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EE9C40764
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793271482;
	b=grAX9a5NzIReHJAyN09/AOnYelj7d4tC/CsvxU1mGAsKr/ZNQ7RbfXWxrj14DebiQaGV
	 /+gCcoy7C73XgMHCW+xXOueC1j0pLW66Rq6HbiavioWwAGi0rebcZj/saMP2eTeOF9Va+
	 TZQOQFEujFbdtioHjpVn9U8/b3be56df8eA7f5BeN3Rc3euHvbP4luWfAOORaPSlDDPyb
	 NpJ0bD8CyVMEVR7jlsgzUYzczjX+NFv+a/0ATBbxzUsAJdlJWY5VwO/GoL33lpgTsqZ8N
	 iAe7RxcKn6OLL6hqxzy9LJpPKVLwBMVw3hJeLwHqkBxPvycvoGtBFAgsQ5Vnb/ZqTzA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793271482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	b=GhdytRPJE99gxeMtSLSClKx6VkNBUmglSK/0RuqUsau6Do7EfVUXiHy84x5IImgvwnqc
	 1R+V1kSlRAbSMnE2DJgMaw19wzJBwy2qWXcgJG3cRj73iSe2VQAP17ph+WXlaIwl4SXDz
	 Z975v08ySKtXcSiA4h5dwI86wo/qwf4tizxoCeJhHzqJBvYH6cysmuQL6KwL9wnjvPlih
	 jB12GY/7gSLWU3xm0PEt3v79eaRqGd+6k3cJH+peuafzmk3VNr2w/6XaLTLU2eWfGQ4yG
	 CQ/Iw3bDLO6JWmRXjuwX/DQrEvyG7VzhdAGROn44elPYFdrYrT8k4J/WMnH+MZ3lE6Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793271482;
	bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oO43gziqAsqAVgwt3AlNpAo0B9f/e+aZ2Qxa/3EYOeGti1YUjOrIS22IIuI2aWDG/
	 zqfVvtRxTeah9GFtQpiuUmcQxzLzfKeHfn+/hRo3HwYRKPx4rGxZ6/kNSpK85kDz5N
	 Lr9P3LvgSH4aNvYW6XODWFRbfNDKQqO+cXzjLnkU09Rpnx57gbhqN352Jk7B2qlG6/
	 VTtUADBcW5E7SyEKVrNCqDIpegNgdv6IPVaqQWmj5I0mDbYWOM9gBvQ9NxbWoVgTc4
	 zoXf8zhydoMKAy6FagZ1EcXBmc3UgxplTUYTYYB6J72C2CQQQoRfjDAnNzifT+OLNr
	 /qDUY+kZ1OSQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EE9C40764;
	Thu, 29 Oct 2026 10:58:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F8BF334
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0623B80F97
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkaLMVcwZzBN for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 10:57:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6DA3880F86
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793271475;
 b=Rp24uI+viZQAurmJfhuAOjbaAfLuYEQ0OJVD18gQbuRy9uEWt7IxI+5OWh/NfUUzSdV/
 LqCDgKLnwRaXRBK7A5yH3MJ5Qs3s5vC602yVuT97ocowzI0b6fQ+jR2r1EQ6ex6PZbIzg
 SchkAAcnD1Iz9gQ9JV/5h6PgDG5RdxIyEzYKDI9qjCBBt1GeVOzc9EepYvUsrVIHUXNg0
 Jb/C88Y0btX/z+H4/be4z3s6vNTe/WmzoiACqnfiBqvPK3LKZXoaIFK4X0KGmqPsiY0fs
 mF+yfI9VW/JWwn/WyItFuWs8s5EbVQSAiZ5PrK9OKE3BuXGHDKYQTUUgRXjOMxVcnuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793271475;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=HNqFNyJIqtL8pghXUHv8ZBWlgmbRCxutyagko/qh0MmvnFFpomuprxwuo/HjJzcHU0GK
 o3qTvpgmW5Pxdz8VTQagpDp20eB0dp1LJlachuM3zc0D4dXgL5Q3jd+hGOWafNLGMz2kk
 OFvkuu+C5y59KeuxXhhv2GZLQtugWb1t1dLojUp4rYtLMss8v6U4syUbQ5QosBrtzfrO5
 6QzsFA/7Dr6I93c76ys6GGLP04JR/5vxirfxjpXUzvBHTjJd0Y6oLJAuXjOFjVlfowrhd
 fCuYOcuBqp15STdpVXfCNqxKoz6E6qkAGd7XqO/oXI/6qyFMhL7DIdU7/3xNe1abd8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=kvlBa1z1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KCjHriUd; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=kvlBa1z1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KCjHriUd
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6DA3880F86
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TA8iD8821712
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Dw0YQ9AdyH0
 093F4CAXrS1D6HzWf0L9XIPmFuwc7410=; b=kvlBa1z1X75Db1SSnpDav+zpfhb
 +e/pxyxR7i+SFuwnXiHzCJEr7R4FEdFfEuQ0SpDZcJO0oTVUIPJc4XBWtzfBeRAA
 6nf1WR8Q+y/Azo0vrv1z+CCvaEjlGtd5/2simNrIXgJSmAd8pQxlBk2zfVDZ3xju
 vKZ2fZHAXcImDKN69zpNaX3RkDZFGyycBDpyt+M6jA5CDWLNwFi1tAck9w393kC0
 c4AnjNZZdG+n8swxVHmmWNjbvohmQerX8kMq0J0rPT6C1w+pk9WzB20/Ktf0Taew
 wbvXoQiJb1oQW0jBhZ32tJgWZywLKgwzX5KQuFgNuxzi+Iq4jtXsOj/xChw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q85g1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 10:57:54 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a1e2485fdso4326922eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793271474; x=1793876274;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=KCjHriUdnHkau505ElYnYjwesOahJzp3tORTlEXzR2JtXaaDm8gZ7xIrwIKnZkW2iP
 9/D4GE5qm3996PC1udVlrBnIxWTEl7Agdby+3u5cv1oeUiwl2NZB9sbgPWzjeSofHvln
 C49dUCWVjozDIq4D+l5Bh5aJEHq0lyOc7XI8LU2ohyNEX0jJclm/Nw1Xh4UUrecWoagI
 UASrbNlfvcSX6/5lvRbkQ4IaiwPqrGJxqTP7LJviD+G/4LEdBHP5lBiiDlbjoslf20Jt
 udSamTD3p6QpNpNmw6ZrflDTmvy0Bl79+rKl7zItp0iXEDdGZGoBMP2by2ZjFTAljxFP
 hoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793271474; x=1793876274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dw0YQ9AdyH0093F4CAXrS1D6HzWf0L9XIPmFuwc7410=;
 b=PHWf6uy5FaCpzL4PmYed6816eb5AZtKPdX41WLbSQ5v3oyUbjI549bt5NWJn9dhYSq
 JBNs2xT3ob+nV8ft/PePthd+z468PI6h53fxB9REunKLnEwErMrmVmNLrrA2P61xzJVA
 IIvvvZXMZXDxuXGdD7V8cbv4NIzTyHnQdVceitYTiwz05Smd8URurdyVlI0QiGtctB4N
 L7Ew2iPw3yMnu3wQmHz99t+gMIYnaoWK0R/UrrYBNWcwZE7jXP3AcRzIdlObsCJ5yVGd
 ZSe4W+5NUJb3S5Fvu+B4nhpq1O1PkKoQGPLJ5TkJci9eZSrYwGez5kgKWZVmb6+rLcfG
 hw7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/9feLOoaJTohvbuc85T4IFAXpZqtJSU4KOPNT2oFYNjyfzWZxz7XdfLfDMgs3mBhb5JjVpbI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIFEiTZcjF+WKOTMWK/h4vnXJYehD56Rg0LFDNiso5Ka1lPbabo
 oYKp8FKjArQ6D2GSNB1kq8ugf+34+P0jhPTtzJRKWQCxWx45IWZ+nr0YLSeTjUC+Mk4ITEeHyVh
 ZKA3zj94T+LQZnzVTfDpVMGnIhnNlaSGZMfhMnUql/3MYfDcUxF5FYwhJjoqR82HuOPI3m4tZ4y
 hiQq1L+A==
X-Gm-Gg: AYBFou1zlVcuUaxQU4v/AWtXll6QbObmcsXJrwd+1bez+Haace860+kN+jnMigQ24XW
 ZgqTJe/NAaBZE8prCEPx32riwzOiRfpHY1sWBprSRjB6p9mc7cXpn7mjFpoGY/dpXHNDKb1b/9p
 n2hzYjTP/m3GJQw1gLMhCUDFoHPV+ffew1IEAVyFgnMVweYDTGBLt4lJxieMV7TdGj5e+p1lfQK
 fLN+bh7D6LtM1NHeCvGjyGBlzPDJewxipGHGBl7c8FGN/fQDzIUFTt0SoN+yQtsbmLPvzCfu9fW
 Zqevb3tFNBSONa8cXylqdVEj4gJ7OsDEtsJGgOZpMgzsuGCyl0oQdC7aYcmrYWkQfehTtfWHWpg
 Is5iD4ueej5kM8OOM+M61QZ1SkeB7rxt9MHvc1dELqqlwQ2pXeoGNGEY4fWdkN5O0oN3avb5FBa
 rF50cvkdUlBqw5FNUdKY8PTg==
X-Received: by 2002:a05:7022:170c:b0:1a7:7160:ffc8 with SMTP id
 a92af1059eb24-1a77170429fmr5085656c88.10.1793271473479; 
 Thu, 29 Oct 2026 03:57:53 -0700 (PDT)
X-Received: by 2002:a05:7022:170c:b0:1a7:7160:ffc8 with SMTP id
 a92af1059eb24-1a77170429fmr5085603c88.10.1793271472754; 
 Thu, 29 Oct 2026 03:57:52 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75d4887easm14645551c88.9.2026.10.29.03.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:57:52 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, nathbappai@gmail.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v5 02/13] pinctrl: qcom: add Shikra SPL pinctrl option
Date: Thu, 29 Oct 2026 03:57:35 -0700
Message-Id: <20261029105746.3487456-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
References: <20261029105746.3487456-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfXwPLXnaZh/CZx
 12JoYUTb2Y9Tik6S8GtmILAi8caaHDaE7R7ZqV4hgW2crDK1Ofqd4WaswGCrTKXET4aMIa6xjCO
 PCda6lqmMKEhBpSeocouFu0iG8H0dw4=
X-Proofpoint-ORIG-GUID: ri3Cj4Xuo6oaQic0HcHVI8SmZ93lQg9A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MiBTYWx0ZWRfXxdJ+rhq39ynQ
 vr3GELrO8bxJryn331S9NH+L5lrZcJA7YeTtcronG/Iz5qod8Pgehpu+8eCtxZqAivNXYS1lDZ+
 elu+CsGo+BGWnmMm/i3Oaw720ceac3XWscJseRkRF9pjSrnI6vGrk/PJhbOJIOZVriF09+fM5Bu
 KW+6DVWTwbW3yeriYjrfaJdtTc7n2vVxSF6W2T/dJ5aJFq84MO0VjQjeVo2h/cgemQge/ln9PsL
 Sr44RhF6lw0CRznmnEr6euqAd52Qt8gAE1vF/jnVaqyl1hAgiG/E4LeqHnpdBZ1v8K7AdenNIx2
 besAdkhUQ+ekYKU/ll70vcHcSC5XktehIfmiVpaZYS3Z+bLMrOUNml4k5AZCbCjeILzYpVWkc9I
 Oqg0oqhsauFbZO2YYDOemcwh3tPTvZTXZd/qCSfjLnkX2CO0m1O3RPh9OyGN279GvBmRib+ivKW
 frYpI+bNmFw2emqi54g==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae326b2 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=6lju1O6RD8AOoBC9Ya0A:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: ri3Cj4Xuo6oaQic0HcHVI8SmZ93lQg9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290042
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

Add the SPL Kconfig variant for the Shikra pinctrl driver so
SPL can configure eMMC and console pins during early boot.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index bb12e93853d..ac0103631ad 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -116,6 +116,14 @@ config PINCTRL_QCOM_SC7280
 	help
 	  Say Y here to enable support for pinctrl on the Snapdragon SC7280 SoC,
 
+config SPL_PINCTRL_QCOM_SHIKRA
+	bool "Qualcomm Shikra Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_SHIKRA.
+	  See the help of PINCTRL_QCOM_SHIKRA for details.
+
 config PINCTRL_QCOM_SDM670
 	bool "Qualcomm SDM670 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
-- 
2.34.1

