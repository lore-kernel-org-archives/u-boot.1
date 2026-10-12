Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2219BCA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B36C4058A;
	Mon, 12 Oct 2026 17:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id leHQTeKJ88ej; Mon, 12 Oct 2026 17:08:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7DC8040574
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824897;
	b=nHBLCzM5xGpxByRuatHg/Agtqp1WwRqRmFzFmGP4W2G+8n7+i5zOESvj7yrTZEBvITjw
	 iFClOedDQXDnzAlLmkiX+mN+9NCFbg7Hc+i5F1cUsjFxGKckuYugl2y+i5oxFvpp19Ts/
	 3HUzInKVCP0BRA+Pq4Wu1iOmQp1g6i5lSlsxvbCxYTgq13Li3PxS8swNuDB7EBsH0V32q
	 IdCIrLy5UDQQoKutiY8yBr+cwlnD9rD4fY+nO34EUM0nH964jPk/RtbBoP6ZBMaIM+V8b
	 RbvPu5WbBL2PLU8Vd9qLz+P2qtR5R63oFOmJy+h6V4rcTSLOC4Hl8qBXusUFLd6kS0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EOygcRvNijNH3O1Crbw5Hceb1OxsL2y1g7EsRWUt6kw=;
	b=YdPJoWf16e6Qqaof9JU8yrEVDb+Ob5bZs7Yu5HXYAMXSjpWNBxDZjQMD71jLDLUfhAef
	 RXOsFGL6rfgppIA6Znxd1NKi3xh42Tn/vlD2YNBQwNKH3NP0iHY5OZ5ld4anNb4LCwu/Y
	 9YiBC419cCC50aTuiOoyE14JiiULhWQuQwzVmXKqo5RCgn8Md3yllJh2N5u/30Y2ZprBe
	 R6m7ce+u664Cbi+WzmoJTDgnpo1jU+XoONMmMKNBivEWipHv5F1MH0T/3jyBbB5kKha3P
	 mCL88x+yfe0QxhrYtpMdQBzxcWeh9sn3g4a/3dwZrcehUVze2LN0ugwZHyOBtEt0MhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824897;
	bh=EOygcRvNijNH3O1Crbw5Hceb1OxsL2y1g7EsRWUt6kw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xw/BGV511L17tn4miecVsvTWmZlPfc8Wwdhn9hQouZv9mgY9UEo8GUxEoQvT521wA
	 g+sxea+o+0/AA0gGWPMjH/yQ0VoDY4ebPRbG8GLNqxte08cNMURgRfGf9DtHnzwBfi
	 601t/8dDOe3e+77LwMFmbQCNm/sMqb0jnU2IIZK0LzbINb1CihL5OlKRD52ochbkSW
	 H8S13DWSdCoJNWSFqpnsgjei8gx4pFooJxnuY1WNrgNaVaZwQL2d2zFlEOuWafx9jx
	 DnYAg0Y/B6NLcQqBcYzxpndZX43olXJEtZsDUAigta9nyRIJhwX9gEiAMihSlLYL6+
	 1CHMSh8aYnXEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7DC8040574;
	Mon, 12 Oct 2026 17:08:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 53843156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39A8C80DC5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cMbkVkwdG_jZ for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 17:08:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D06780DC2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824894;
 b=RxhAEru7LthhOIHuRCS3vTi7uszQqtgzUxSQfpebYgyMcyijV+KW3Uf8+SV7QInyY3Ge
 4opkaleM45twG/s5u4DGBefnXuO6D1L8R5WJXWVVg0PzUSIkUAMsy3r37gPx4EYWp0vxV
 Uoo7zsv1Z4XCW0fLvmDNLGv6ptQsMQmeutGYxV8WJSSNvk/uWMxtTSf7bC07SnfQp1tqB
 vFhHE/XeGMevOjWjab/C9by6QAF1k4BkuYpCQwAHfPO48MMH4y11ygBLMBNOxEBF7EZUu
 y/ddZZ7PIg4TgI8m+ljTVASNCvwn1pBx3jrSmh0ZC/9cWbo+yakow9btPGAYb31ZybQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824894;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=EOygcRvNijNH3O1Crbw5Hceb1OxsL2y1g7EsRWUt6kw=;
 b=k/kB4VLkSmTUvIum4zxJe5GAxeh74MOEgMbUEFaqRDql8Q+t1shHnAjMPXLR2H+cGFx7
 EXbS4KBosWfkZD9XiAet0RNY1re+v8yVkzCTRcKISwEz60dsduoSuK0ImNoob/qwat5UQ
 pILaY67um3cjRVVmk0/sXrHcaRGuHY+S1LgM+mW1hoBHOw/+JQhMaG7dv0yFMb5a0wr8g
 lXBHJ0so/lxjtH0xJxlLD3kWLrY16vpUUCQzpf4kc06SuELihX9zadwQ3Cj2eQqsJ4mb2
 4R1MwkmpiBok3ugPfCOhEfQtJpdfOKdGdJJFrfB00HHN+ZH2KFFFYNgow1ZAhTmJZIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=aVGmoIgg; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FvjTDvtJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=aVGmoIgg; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=FvjTDvtJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D06780DC2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:13 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFf1Nh2175397
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EOygcRvNijN
 H3O1Crbw5Hceb1OxsL2y1g7EsRWUt6kw=; b=aVGmoIgg2EPhPN3M9GI4wr7ia0t
 TikNeHfpWbz4Eloan6Rnyqerq+TNM4Z7oMeQNMH0dguAMF0tsb+oxyzBoSdFPL9t
 UaD/AhW87jnPZWNYQJIQrzamsN2MJ9YDoP0b/xAVDKIWq7qEnuO/KsoFsHctlsIK
 lcAecNWKETLZjFMtbt/T8eScpkl7D1hSzSZzr6hhAmlzX0xIAE7HPVx1sz1RA/Be
 nW57c9Q7wYVkCcTuFGRgl7a7Q9zUS8CF66AFnZL08ZUih6L7zHYTdBk1OMundAvO
 HLA0ZRWtwZ4q+iONeuE1gO0GH+f0Y5v52C7d9KZo/DVFbl65wvqWeLgveOQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wbc1xuh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 17:08:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3510d0baf63so5947197eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791824893; x=1792429693;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EOygcRvNijNH3O1Crbw5Hceb1OxsL2y1g7EsRWUt6kw=;
 b=FvjTDvtJEjgs0GqveCyC2rZAB7UVPTpuyJJ2Jl/9FaXFpY0vkWD2ql3oFIZ9y79Kk5
 HKNMww1APUuM21vNFXkTjkW2kgV5LiQoZ8lTP6jlnzdFm+qvO5CyEgdmvrDH9aURDaa9
 hhbUvviLNgv8zpfWiBMOU5EiP9/QjM/pia0jYTwaso7ZD/2WfL6JTScYEL0dMGvNAd7k
 iSi0+h0whz68hMxxZnBmPbL3tMKEx5+ULSxV8+7L+dmoXV6qCebppQKGJloTxSFlMOdC
 tg6akHWj+jjRso2PpV14GSeI8OV4tfxrjohuu6+UZM9jSM9JY6DCaF511HBvxx6MvBM/
 rYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824893; x=1792429693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EOygcRvNijNH3O1Crbw5Hceb1OxsL2y1g7EsRWUt6kw=;
 b=jl3wRmKqlPzLOfPLWuGlM1CSEoACKuFxQSsQezIYdfeoek2hjz+U1kgAlLxPu/7kxl
 2VRKEivIBhswfhhxCmKkoBkH16PULuDzvjCunEK3+KvTnD1WySCqQAkSqGX3HLA3Nhx+
 /j4EXdM8qC7eXorFOvyMHoQFn7fUNYAEhJG9fHRtRk3CyFE2iU70udUUuJOXm/aaF9QC
 JaQjHNMnQxVgFysPIODA0WCWe/+Qijo3p4SoJcBWOHf9mhFmbD5RXO2xlvyvAieZjS/9
 FguCxA7An55P2P2oGTsVXUwJDUvdaxcUN/vxRYaeSLascWsArS3LaFLtUuPWh1bcOHiH
 g8ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdGn6bXjYkgYf31jsuB+trGvEo9TXGL8HD+HBc0aaGjos3iY9BYCDjRFLmA7UwVcUU3EZOzf0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJZaeh1GXvM5sw/+R7pnK5odVxUhjOeluP0YmR0WV+Za3Dkz5TD
 joYjFE6iVyXd+KcT36tBofIxuWbWiJFqkLPTu90EWtKUWOQ1rWXMyFkPIPN8NSPXfw4GAocwEr3
 5gPeolgNmkVoeE5LIDtgqaov2AHtJ5Pdp0Jmx6nFVexjDNyamYdlC6oWSweekEyQzG8fsKh0=
X-Gm-Gg: AYBFou2gCdx2Y8elJu7iK5KV7PaKEreOZ42GUY8ehgZ39Sab/fL2ZwnjtAzlkTUSwuQ
 bYQStsQ/bcoxUH8e8qkeUd1Zxs06l4S6g302FFkz/MBwqzRRusJu6n7N3z60wgjHmUREyDOm5CU
 wugVcnfv7/cWDXjiJt5vJi3Kp9hcWGkMx9MNvGzWEUoQw7+hfqvPDJBYapUOyxBgfIvVpWPkvrf
 9rjOfNo+W6goGVJAwKgM1oUKzxRDuGxBg4QlxVevYqUukX8UHbVXr1Sb3SfyCCSXIYPvZ5wMRUy
 eHgTWqqkMLBdTexZR5GuLP2qSoEOFgt4m0qI5KY0ayn9W1BRSq5chPKjxmVkPa36TGBCSdSdqOx
 JIWG2bBJghJm+TuRWSdd85+I5SsHWmSBfx1DiFx1eLZGAuM+ElgjWuHz2kEguoXL5YZ/le7mJ7M
 GzzsgJaXGas7z5Zmn2/w==
X-Received: by 2002:a05:7300:e9d6:10b0:359:bdc8:c9d5 with SMTP id
 5a478bee46e88-359bdd83104mr7899295eec.21.1791824892256; 
 Mon, 12 Oct 2026 10:08:12 -0700 (PDT)
X-Received: by 2002:a05:7300:e9d6:10b0:359:bdc8:c9d5 with SMTP id
 5a478bee46e88-359bdd83104mr7899240eec.21.1791824891461; 
 Mon, 12 Oct 2026 10:08:11 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353814b556esm39945402eec.18.2026.10.12.10.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:08:10 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, u-boot@lists.u-boot-project.org,
 balaji.selvanathan@oss.qualcomm.com, Michael.Srba@seznam.cz,
 nathbappai@gmail.com, jbx6244@gmail.com, quentin.schulz@cherry.de,
 anshuld@ti.com, marcello.bauer@9elements.com,
 tan.siewert@9elements.com, u-boot-qcom@groups.io
Subject: [PATCH RESEND v5 1/5] misc: qcom: Add HW-Info aggregator driver
Date: Mon, 12 Oct 2026 22:37:50 +0530
Message-Id: <20261012170754.1606314-2-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
References: <20261012170754.1606314-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfX75xvWLNo84yU
 elvFsxVZBkbvqVpKlUH3g00/S3M1ZJnnmgiGRnedJh58tu0xVwDyMPhqJhXXpORLUnSufzu+1Mz
 Lw7J80tgiMisItnhF7+5fm7aStbt368=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2OCBTYWx0ZWRfXyuqq1nNDUjC+
 o7mA/CqMcmCDjln+lu6hNne0U9Ha67NBWD+ORU29wq1zxm5z7r/THVMVdQM9edcwiCBaryw4H8V
 2+YMNIzsLjNGehQh509WttvwNqNOfCgnIDGp4jA7YtIBs4V1E4Wne44dPd4vmeOUigsCGszTysi
 Tw3UHk+ub5XY4QGizOPsO+GM78rm2Gbf1ZSZerxToRfa0ImkeY7RKvVQgxaBzyicIQYiBbZSIsV
 07EWAgKy1p/sdy39ldaqoekDb+cuIFoBbYNxDO+I23pKXVP7fv+XrgNsdXOl23iVQ5iT7QBDoQh
 A/PVTJ3Iac9lGFQVPq+/k9cSLuArOpgO/Jv7v/DORXa4qnN8wz8zsKS0jqo6zkBp/VeuTqRTm2r
 kKQXT6N/eUSXNezfyEHEy3Pgstinu1U9Zqy838VCZ4xPkRtGDvJ0JJp+d4F+1VU9VpJr79tRPtS
 MYutd06CvTeyUuisp3A==
X-Authority-Analysis: v=2.4 cv=C4p8WgP+ c=1 sm=1 tr=0 ts=6acd13fd cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=1VxDqnHFAAAA:8
 a=EUspDBNiAAAA:8 a=nHztRHiazSddbDhVNzsA:9 a=PxkB5W3o20Ba91AHUih5:22
 a=aZ5uHUMKh6B-zo3GvD48:22
X-Proofpoint-ORIG-GUID: 4rX-jDXetvsSG4Nk5HmUCZ8yMMUIr2R_
X-Proofpoint-GUID: 4rX-jDXetvsSG4Nk5HmUCZ8yMMUIr2R_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120068
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

From: Aswin Murugan via U-Boot <u-boot@lists.u-boot-project.org>

Add a generic driver that binds to a U-Boot-only "qcom,hwinfo" DT
node holding phandles to the existing IMEM/TCSR syscon nodes plus
per-SoC offsets. This provides a common interface for reading the
IMEM boot cookie (used to detect boot storage type) and the TCSR
SOC_HW_VERSION register.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/misc/Kconfig       |   9 +++
 drivers/misc/Makefile      |   1 +
 drivers/misc/qcom_hwinfo.c | 160 +++++++++++++++++++++++++++++++++++++
 include/qcom_hwinfo.h      | 109 +++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/misc/qcom_hwinfo.c
 create mode 100644 include/qcom_hwinfo.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5f22bcb330e..95eba94609b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -102,6 +102,15 @@ config QCOM_GENI
 	  for providing a common interface for various peripherals like UART, I2C, SPI,
 	  etc.
 
+config QCOM_HWINFO
+	bool "Qualcomm HW-Info aggregator driver"
+	depends on MISC
+	select SYSCON
+	select REGMAP
+	help
+	  Reads the IMEM boot cookie and TCSR HW version via a common
+	  "qcom,hwinfo" DT node.
+
 config ROCKCHIP_EFUSE
 	bool "Rockchip e-fuse support"
 	depends on MISC
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 9ddbe9cd114..1d484f97bfb 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_QFW_SMBIOS) += qfw_smbios.o
 obj-$(CONFIG_SANDBOX) += qfw_sandbox.o
 endif
 obj-$(CONFIG_QCOM_GENI) += qcom_geni.o
+obj-$(CONFIG_$(PHASE_)QCOM_HWINFO) += qcom_hwinfo.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_EFUSE) += rockchip-efuse.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_OTP) += rockchip-otp.o
 obj-$(CONFIG_$(PHASE_)ROCKCHIP_IODOMAIN) += rockchip-io-domain.o
diff --git a/drivers/misc/qcom_hwinfo.c b/drivers/misc/qcom_hwinfo.c
new file mode 100644
index 00000000000..822968234d5
--- /dev/null
+++ b/drivers/misc/qcom_hwinfo.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm HW-Info aggregator driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Binds to a U-Boot-only DT node (compatible = "qcom,hwinfo") holding
+ * phandles to the existing IMEM/TCSR syscon nodes plus per-SoC offsets.
+ *
+ * Example DT node (arch/arm/dts/<board>-u-boot.dtsi):
+ *
+ *	qcom_hwinfo: qcom-hwinfo {
+ *		compatible = "qcom,hwinfo";
+ *		imem = <&sram>;
+ *		imem-boot-cookie-offset = <0x0>;
+ *		tcsr = <&tcsr>;
+ *		tcsr-hw-version-offset = <0x8000>;
+ *	};
+ */
+
+#include <dm.h>
+#include <log.h>
+#include <regmap.h>
+#include <syscon.h>
+#include <dm/device_compat.h>
+#include <linux/err.h>
+#include <qcom_hwinfo.h>
+
+struct qcom_hwinfo_priv {
+	struct regmap *imem_regmap;
+	u32 imem_cookie_off;
+	struct regmap *tcsr_regmap;
+	u32 tcsr_hwver_off;
+};
+
+int qcom_hwinfo_get_imem_cookie(struct udevice *dev,
+				const struct qcom_hwinfo_imem_cookie **cookie)
+{
+	struct qcom_hwinfo_priv *priv = dev_get_priv(dev);
+	const struct qcom_hwinfo_imem_cookie *c;
+	void *base;
+
+	if (!priv->imem_regmap)
+		return -ENODEV;
+
+	/* IMEM is plain mapped SRAM; safe to dereference directly. */
+	base = regmap_get_range(priv->imem_regmap, 0);
+	if (!base) {
+		dev_err(dev, "Failed to get IMEM regmap range\n");
+		return -ENODEV;
+	}
+
+	c = (const struct qcom_hwinfo_imem_cookie *)((u8 *)base + priv->imem_cookie_off);
+
+	if (c->shared_imem_magic != QCOM_HWINFO_IMEM_MAGIC_NUM ||
+	    c->shared_imem_version < QCOM_HWINFO_IMEM_VERSION_NUM) {
+		dev_warn(dev, "Invalid IMEM cookie magic=0x%x version=%u\n",
+			 c->shared_imem_magic, c->shared_imem_version);
+		return -EINVAL;
+	}
+
+	*cookie = c;
+
+	return 0;
+}
+
+int qcom_hwinfo_get_storage_type(struct udevice *dev, u32 *storage_type)
+{
+	const struct qcom_hwinfo_imem_cookie *cookie;
+	int ret;
+
+	ret = qcom_hwinfo_get_imem_cookie(dev, &cookie);
+	if (ret) {
+		dev_warn(dev, "Failed to get IMEM cookie: %d, defaulting to UFS\n", ret);
+		*storage_type = QCOM_HWINFO_STORAGE_UFS;
+		return 0;
+	}
+
+	switch (cookie->boot_device_type) {
+	case QCOM_HWINFO_UFS_FLASH:
+		*storage_type = QCOM_HWINFO_STORAGE_UFS;
+		break;
+	case QCOM_HWINFO_MMC_FLASH:
+	case QCOM_HWINFO_SDC_FLASH:
+		*storage_type = QCOM_HWINFO_STORAGE_EMMC;
+		break;
+	case QCOM_HWINFO_NAND_FLASH:
+		*storage_type = QCOM_HWINFO_STORAGE_NAND;
+		break;
+	default:
+		dev_warn(dev, "Unknown boot device type: %u, defaulting to UFS\n",
+			 cookie->boot_device_type);
+		*storage_type = QCOM_HWINFO_STORAGE_UFS;
+		break;
+	}
+
+	return 0;
+}
+
+int qcom_hwinfo_get_tcsr_hw_version(struct udevice *dev, u32 *hw_version)
+{
+	struct qcom_hwinfo_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (!priv->tcsr_regmap)
+		return -ENODEV;
+
+	ret = regmap_read(priv->tcsr_regmap, priv->tcsr_hwver_off, hw_version);
+	if (ret) {
+		dev_err(dev, "Failed to read TCSR HW version: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qcom_hwinfo_of_to_plat(struct udevice *dev)
+{
+	struct qcom_hwinfo_priv *priv = dev_get_priv(dev);
+
+	priv->imem_regmap = syscon_regmap_lookup_by_phandle(dev, "imem");
+	if (IS_ERR(priv->imem_regmap)) {
+		dev_warn(dev, "Unable to find 'imem' regmap (%ld)\n",
+			 PTR_ERR(priv->imem_regmap));
+		priv->imem_regmap = NULL;
+	} else {
+		priv->imem_cookie_off =
+			dev_read_u32_default(dev, "imem-boot-cookie-offset", 0);
+	}
+
+	priv->tcsr_regmap = syscon_regmap_lookup_by_phandle(dev, "tcsr");
+	if (IS_ERR(priv->tcsr_regmap)) {
+		dev_warn(dev, "Unable to find 'tcsr' regmap (%ld)\n",
+			 PTR_ERR(priv->tcsr_regmap));
+		priv->tcsr_regmap = NULL;
+	} else {
+		priv->tcsr_hwver_off =
+			dev_read_u32_default(dev, "tcsr-hw-version-offset", 0);
+	}
+
+	if (!priv->imem_regmap && !priv->tcsr_regmap) {
+		dev_err(dev, "Neither 'imem' nor 'tcsr' regmap found\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id qcom_hwinfo_ids[] = {
+	{ .compatible = "qcom,hwinfo" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_hwinfo) = {
+	.name = "qcom_hwinfo",
+	.id = UCLASS_MISC,
+	.of_match = qcom_hwinfo_ids,
+	.of_to_plat = qcom_hwinfo_of_to_plat,
+	.priv_auto = sizeof(struct qcom_hwinfo_priv),
+};
diff --git a/include/qcom_hwinfo.h b/include/qcom_hwinfo.h
new file mode 100644
index 00000000000..994a7d0bb20
--- /dev/null
+++ b/include/qcom_hwinfo.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Qualcomm HW-Info aggregator driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Reads boot-time hardware info (IMEM boot cookie, TCSR HW version) via
+ * syscon regions, using offsets from the "qcom,hwinfo" DT node.
+ */
+
+#ifndef __QCOM_HWINFO_H__
+#define __QCOM_HWINFO_H__
+
+#include <linux/types.h>
+
+struct udevice;
+
+/*
+ * Storage type values. Match enum mem_card_type in
+ * arch/arm/mach-snapdragon/qcom_fit_multidtb.h.
+ */
+enum qcom_hwinfo_storage_type {
+	QCOM_HWINFO_STORAGE_EMMC = 0,
+	QCOM_HWINFO_STORAGE_UFS = 1,
+	QCOM_HWINFO_STORAGE_NAND = 2,
+	QCOM_HWINFO_STORAGE_SDCARD = 3,
+	QCOM_HWINFO_STORAGE_UNKNOWN,
+};
+
+/* Boot shared IMEM cookie constants */
+#define QCOM_HWINFO_IMEM_MAGIC_NUM    0xc1f8db40
+#define QCOM_HWINFO_IMEM_VERSION_NUM  0x3
+
+/* Boot device types from shared IMEM */
+enum qcom_hwinfo_boot_media_type {
+	QCOM_HWINFO_NO_FLASH         = 0,
+	QCOM_HWINFO_NOR_FLASH        = 1,
+	QCOM_HWINFO_NAND_FLASH       = 2,
+	QCOM_HWINFO_ONENAND_FLASH    = 3,
+	QCOM_HWINFO_SDC_FLASH        = 4,
+	QCOM_HWINFO_MMC_FLASH        = 5,
+	QCOM_HWINFO_SPI_FLASH        = 6,
+	QCOM_HWINFO_PCIE_FLASHLESS   = 7,
+	QCOM_HWINFO_UFS_FLASH        = 8,
+	QCOM_HWINFO_RESERVED_0_FLASH = 9,
+	QCOM_HWINFO_RESERVED_1_FLASH = 10,
+	QCOM_HWINFO_USB_FLASHLESS    = 11,
+};
+
+/*
+ * Boot shared IMEM cookie layout, populated by the bootloader.
+ * Do NOT mark __packed - breaks natural alignment expected by firmware.
+ */
+struct qcom_hwinfo_imem_cookie {
+	u32 shared_imem_magic;
+	u32 shared_imem_version;
+	u64 etb_buf_addr;
+	u64 l2_cache_dump_buff_addr;
+	u32 a64_pointer_padding;
+	u32 uefi_ram_dump_magic;
+	u32 ddr_training_cookie;
+	u32 abnormal_reset_occurred;
+	u32 reset_status_register;
+	u32 rpm_sync_cookie;
+	u32 debug_config;
+	u64 boot_log_addr;
+	u32 boot_log_size;
+	u32 boot_fail_count;
+	u32 sbl1_error_type;
+	u32 uefi_image_magic;
+	u32 boot_device_type;
+	u64 boot_devtree_addr;
+	u64 boot_devtree_size;
+};
+
+/**
+ * qcom_hwinfo_get_imem_cookie() - Get a read-only pointer to the IMEM cookie
+ * @dev: qcom_hwinfo device
+ * @cookie: Returns a const pointer into the live IMEM region
+ *
+ * Validates magic/version before returning. On failure, @cookie is unset.
+ *
+ * Return: 0 on success, -ENODEV if imem regmap unavailable, -EINVAL on
+ *	   magic/version mismatch
+ */
+int qcom_hwinfo_get_imem_cookie(struct udevice *dev,
+				const struct qcom_hwinfo_imem_cookie **cookie);
+
+/**
+ * qcom_hwinfo_get_storage_type() - Detect boot storage type from IMEM cookie
+ * @dev: qcom_hwinfo device
+ * @storage_type: Returns detected storage type
+ *
+ * Wraps qcom_hwinfo_get_imem_cookie(); defaults to UFS on failure.
+ *
+ * Return: 0 always
+ */
+int qcom_hwinfo_get_storage_type(struct udevice *dev, u32 *storage_type);
+
+/**
+ * qcom_hwinfo_get_tcsr_hw_version() - Read the TCSR SOC_HW_VERSION register
+ * @dev: qcom_hwinfo device
+ * @hw_version: Returns the raw register value
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int qcom_hwinfo_get_tcsr_hw_version(struct udevice *dev, u32 *hw_version);
+
+#endif /* __QCOM_HWINFO_H__ */
-- 
2.34.1

