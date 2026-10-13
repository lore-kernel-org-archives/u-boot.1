Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F30ACC6B16
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12C77809AD;
	Tue, 13 Oct 2026 15:31:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GHKmdZITLq3j; Tue, 13 Oct 2026 15:31:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91D9B80C98
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791905514;
	b=sKpIUIBGvjSYzZqugRc0xeOTEOgmVFHoHmGR8v9Pv1J4y9Xu9Vxy6ZPVBvKUPdLhjYfb
	 7MCPVRhGm6MwHqBeXAh6WpGmWgAstMPGJivDJL3bUv3NxmoU2+8PtmK1nkLPPYuAFWgKy
	 qZX/bkUJO3I4scmRAZKobOsaH2RZC1yYka6rJJ1/dKRnIeqYkh0ItK+VZJmxR71WSp6W+
	 DSwQABbjGHT3Tr0oWJn4JZetBFNAXXr+MaZrKQkpy84RfIWwZf0BrLeFtArCtSiwd0XyX
	 hJ0Hlr/O/SiMowiB+M1qjvkVDUVw+uTTnDVubxMo46tugHm5YmZUVW+1kmTMMqe4RZg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791905514;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tMGPX8/PcWKzkiFnq4d3rCM2HG6VR7ReGL9meGM977M=;
	b=l867gxhf9Gu34uKN8K/XsWTz7vp9wXMsfdXCxfNYOAJR8dvOH4yX4hF++Be1rmPvAScR
	 8w1zY+FfRbyiCd2beAXnhLCUa1epCBWY0QVFPbXuZtRuj3mZQ6SYviWhXf54Ylg2Hgqz5
	 zTnjpwy/8MO/Q2g5kZu0sjmIAZVJeU52Dd2sIqhgc3k1r5MZb7mkGb6UUESzkVM750JDv
	 /76xvD63/9N8btalM7JcqO0D7C4/Bs5w1QeJ1u/HLmTeR3sam9S9DLHrk95+Eb4JaLhav
	 iic7MCwu3w249L7cNHo0gF3SGBJBq2LZzAKiKJpgYq1pTOc8Q9ira307mZDGK/LjOjQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791905514;
	bh=tMGPX8/PcWKzkiFnq4d3rCM2HG6VR7ReGL9meGM977M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJkFX1WmCmtNl2hmmgvkg8KrQutzfm/ow/EE0/m8VLBtFZ22bqaxGL79Dwy2nAcq7
	 09KhE5Xy2rlpXUsI2scp3CRQewz1MVT8ILpQj/55Guunz2Tx+mNhH7qi6JIO6ZZaTb
	 7OCVQhKEY3LfbdGYASjRAlBzzrfgvrTsM1BuF3UvPGi7wacDVIkCv1lgsFCUqlIvEo
	 DkKBRiUH7c86iv/wh/dw3pQ7i/LXWebSKfcU7NfImvg7bGi2Z5vMuxow+amopLg5VG
	 1z2zZPfnbwKhHSo8Rc2gMjvAbMsltyRmsyfpUriM/T5vorgRY/ZKXUE1WzFCihN06G
	 9VwHgx64Vd2ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D9B80C98;
	Tue, 13 Oct 2026 15:31:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2EC36362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:31:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2039A6072B
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:31:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4T0o-zuN6fDA for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:31:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 56CC76077F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791905512;
 b=bUQRZafvKVt+nhTvl0akUYDATvxkAXPDI6EjUqidrswem+xDoPvjcb97bPLf66lFim99
 GUWSdEc4pAzfYAiYWYSb+lRvpzqEEafb2fo+ggSTM1HE3CifocV7T6kGzYV+xuCh5Iu/U
 MRb2xO/Yf7KLppB5JJfcxWgE70UoljVbRQz53Nk+una4zOgknkiMlC73G8504K3NLcEDT
 UixiyjrW+tX+UTOioBpv4CEU2DF4ScGD0g8yl1oadalnhfvLAdrlXOqo/sP2aq53wYIUQ
 boGdChxfwJ+3FldbQEN5W/dcAX7PtGP7zXpbTNzsOrynTr5IBI/XLquFEk+xre1OmYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791905512;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=tMGPX8/PcWKzkiFnq4d3rCM2HG6VR7ReGL9meGM977M=;
 b=LMF6aTu4wfR5t300PsrSjcv5fNBh/GdiguLciiTuoAXseyKRiSqpQpgDxAfTuXJ0kpfb
 2ifQdbYi5OSeCKGIINdLjAAlJHPM/wGd1V3Az0dyQ34DezwEi78VVADID5a2QediEJ/Pp
 U86hOMYkrtPN3xtZH/r6F3z5duKy3VTEf22C2O+FTVIcc5k6bvx0niPSZqN60bPkSv5GS
 CWf0QIJ8IqcThlmioV2IL3HFUacMHwopLOTFDChykRTYRXfhPKYq0EVqtdTBkyN0aIbZU
 hw6hq4ejWvLOHdUVzETDYNFA3wjhqosU0gp0OW+E88Cledl4zcgWeRKQKc0bu2kBzaw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=l4MYjo64; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LvGWFz30; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=l4MYjo64; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LvGWFz30
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56CC76077F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:31:50 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DE40x5615484
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tMGPX8/PcWKzkiFnq4d3rCM2HG6VR7ReGL9meGM977M=; b=l4MYjo64HVvcsOE0
 6t4DTGooR92xKSqVLA4w3WuNbvUdnza8zWlm//lutPOUUfnBitaWcbXPpSK+eI+z
 3tMxAsJUls8WKKI4ErjFMBiPlTECnCxWlR3dfScVuDc0WtqSRKkk+tru1vkQgACQ
 C4GEfZznB9TmveoWQ8vAB1XbeQD9uiRIzD2iuptod78OxEeAmsjb0+TPlCmeCEN7
 IMWCsyAqkByRMsoQtFTWt9Lu/5N+sIvmUyoWeHXJO+vJBAHvl2yFITmo46RKWEtP
 +2Jrzb79oIDgvtZ4VFmA6rm0ZR/3mNG8hpJqqM8foWC8zyAv0SH7W0ejRmWjUHZ6
 szMVHA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7jau6x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:31:49 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8a88d53c7a6so273997b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 08:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791905509; cv=none;
 d=google.com; s=arc-20260327;
 b=svZdMT3Lcf3G7orzF5Tz1e0LnEUxx0SSfditou84AFsm8RLNbIBqDZ8wDC69Fn4VRA
 ldt9XXzfceEVXDn9MPJbOKtdrpQJ+di7NY59oRbKUtjaxoQL+wk7x9yh1wzw2FgSWnZT
 wDQ/vSbNjRlU97qQj4c28h5zdV8QgNhnHRl0dXw3m0Afd78Y6GYIWVT6EzdKRAijAa5g
 Hp2y2nnDlT0+S6nZWhKt+rcncJGntORkeSDApIIY4Ou2dYdGd2lX7v9kqJEKUWJMg9Iz
 mXMocoJ4piv946o1MKmXd7QBgVTyqq+8E6h5czLs8IsDi5Li2pihketHTu4ywJ7RHKYV
 6mjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tMGPX8/PcWKzkiFnq4d3rCM2HG6VR7ReGL9meGM977M=;
 fh=V/j6Ueum6vjVE9HmZZcWszPWP/Fm3sIbVCHpYxzP85s=;
 b=bQFsrU0+wmYzmrs4BfqvU/pIWGA8kbTHrtNhMCN84FRv/aOVkG/6Q5tREbD1y1l7Sl
 +cVDikYIggbXndHUSgz8zY20h+xlOEH47p5MLOWZp/KPSwsl1PcOTRdb3HzDeA4er7bX
 2unIy8eMxO1+vT0brEMfo4PRrB+XlmH0Jin6JP2BvNhVQqGTNf1LD0FQVOjgXtNvTYh1
 7GaMHL3zviupIpdq0sqbTNXPIZZXV0anzA3FZ2THiN9PlVX+LTPVjkzTlSbZmu8QCpwk
 GT1g65wkOlIPF8BBl6QxKPkI/KhYgKGh4X5NUz990bRv/JSDRCror13lLdldWiC9Tjzn
 bl5w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791905509; x=1792510309;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tMGPX8/PcWKzkiFnq4d3rCM2HG6VR7ReGL9meGM977M=;
 b=LvGWFz307PuJqcYfu9Rp0J31akzZAQXF4NPMS3hueCgf7XBT+Z5s+IYpWlTkOwnVNZ
 GTIOJpruO+S7zNCjV6CdolEEsX6kS1jIwkERLUeplK6XoCJVl/TyH7bU2gMVFel4nWwd
 dg1gZ88RL8LRRfEsIOOyPp3IezMYOEDzGFWbEYvCbvy9qGV4HsIjOEihGthsC0Qo7MqL
 yMbuYmRRPw0qtAl/wykxhB6CDMRiX2E7vwvV5PIF/6T36RSGNoqLdbdSEqxdtTSkaOJs
 R2eUNUljzcqBm1ckn3gBFljzTcoSLP63mgs/fkWZAIP1MIDbsN6CQ4fZbfhakRKTmILL
 z+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791905509; x=1792510309;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tMGPX8/PcWKzkiFnq4d3rCM2HG6VR7ReGL9meGM977M=;
 b=FW+cU1a6ZIfuCO7wgYE9QA35o+aA0gLzsJRU9m/PUIDraqCMRu0qu7+nN8CaA3p8Bb
 KO6WkqmQSjjPOYjFLVt84gqYCnFmZy1+6lddD1LYTjGJlVPd98ks/vXIajoBu5GlDELl
 Lbm5JclqjCdbkZulJwDLpuN7khDxihJ/L+fPruCsqOomM3S5a8QpG33XNtBOjdpR6OYx
 rC6gIXTeq42wXj4XDzrjXm0/vtrbK0gyTllKxN4Uq2mvm1txoReIExzEpRjHiqwXDFxp
 qoAs6GyKReub0ai1cNmSu3ww6IYXk7zhb+3RHOkFrlenMFabJkH2mbT9sWF8z411c6oU
 IvdQ==
X-Gm-Message-State: AFq9FYLwxJKxJHWoe4Bz07JKll+IA0Jx9okdqUTyL0xlBk8x4BSpidH9
 Pg6cuVWboFr3ziTbaMd/0kgPfpTOgy2vi+FYKe7QpP09W1L3ViNw8wA8Ycnaqfk+eIz9pF9tzqO
 ZDO29I7p265xAmvohj48Jl3v/p2YX4Fh2y81wv907BUl7eXkg1NYP7I+4C5uERl4chAf1JbWLeY
 Daj6J+MWaqBqTwKNyyxDiIbmzPkA3tWRzahvUVQTtIcjNlzAZeK3ARKrl2YXg=
X-Gm-Gg: AYBFou3uw6D2BkoFXD450LXbwGHsCcr97GMm67d7PaA7qcQGZJh8CBgwM/kAOk9gJPq
 0oLCm+dCgZeP78jHt/40E57Ky7R3L7HD0+oUOKzsveDKNB60m/TggJsnnebvUHaXmA5v3kTX1Ib
 23A6nv8jSbGCsPwvJpgBriXJOZy99N+9kTmfnQoiHYjB8sk38D+ninP5Pa2w==
X-Received: by 2002:a05:690c:6603:b0:8b0:b52d:4e0e with SMTP id
 00721157ae682-8b0b52d554amr10367517b3.28.1791905508420; 
 Tue, 13 Oct 2026 08:31:48 -0700 (PDT)
X-Received: by 2002:a05:690c:6603:b0:8b0:b52d:4e0e with SMTP id
 00721157ae682-8b0b52d554amr10367197b3.28.1791905507769; Tue, 13 Oct 2026
 08:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261006092732.3577974-3-jan.kehren@emteria.com>
In-Reply-To: <20261006092732.3577974-3-jan.kehren@emteria.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 17:31:35 +0200
X-Gm-Features: AclHuK97RmJpOl2tAvYnDPmgmnLfxcif8PBJDJzIip0diifOYx-hvyM44qH-LVU
Message-ID: <CAPzfCAah3xwR67hjz9Mi2E9CG-zcRj=Cdj8E55cH-0fiPA-XOw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] avb: Take a storage interface in the AVB operations
To: Jan Kehren <jan.kehren@emteria.com>
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org,
 igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: T1ahwK5C9iShW0V-YHJ0SINNZSSQ5d3f
X-Proofpoint-ORIG-GUID: T1ahwK5C9iShW0V-YHJ0SINNZSSQ5d3f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA2MSBTYWx0ZWRfX8Ra4gKYG5j+v
 QqwZFUvZl8trHdaQe8QcQOCYB5g17V+ogcrpsgsR98K2YJptJyYG5e5HKPfWq8WU+p9Pp6vrs4Q
 CH2vn8TlPRnVhWd1r2+dNGs2+5UJAv4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA2MSBTYWx0ZWRfX4hhEHd+RorlR
 aB+2lNEVpa1v8MC6Q6mUzRylXzHwQ/Pj/w/b+MhafU2T7jPQrI2D0KSOezamNXkvwTuujLMa/tg
 cCe1F+extyenPC5o0ZsugE/1T31FZUFANMk8Uy5iOnZlN326wibquLkLpEyLPjocIPdW4AzRuOA
 Nq9sczHhbxgjgBa2sRoMSkGuwbPh46jc8ssti4jrKRGGYpiEXhwjIqHR8iiwfs1XD3C4DoeToET
 f/zlz3+zMep1N/5wOxW2HZKKpHQkv1j3htTxPC+71WFgCDeTgbw0Otzh7TvAKzZ0m8NfCeoJnoC
 BZRk25JM81H6XcNeBKm2SBTkxH9VzEvck+3goMERPrvRM2ov14fAy5gDbiaiZb+FQdW+Xo1wx4v
 GCexd0YCYhaxMoQt+E4RmAP1S9++odA5hQR/Dt6W3S6q139XPmkeEjXS0uLWqyKJT2v8DlBhvpS
 a0hdkGFDxN7NElzhRiQ==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6ace4ee5 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=HAEnkh90AAAA:8 a=0nB6tW618tleYfDMhhsA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22 a=LzkeyO55kmtmzvcb4Ayl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130061
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

Hi Jan,

On Tue, Oct 6, 2026 at 3:00=E2=80=AFPM Jan Kehren <jan.kehren@emteria.com> =
wrote:
>
> AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare devic=
e
> number and get_partition() called find_mmc_device(). bootmeth_android
> accepts any bootdev but passes only desc->devnum, so an Android bootflow
> found on nvme 0 or usb 0 is verified against mmc 0.

I don't think this path can be reached today: android_check() rejects
every non-mmc bootdev through bootflow_iter_check_mmc(), and
android_read_bootflow() loads the BCB with
bcb_find_partition_and_load("mmc", ...).

So the bootmeth hunk below is right, but it does not change behaviour yet.
The user that does benefit is "avb init <interface> <dev>", e.g.
board/armltd/total_compute/total_compute.env, which has been calling
"avb init ${blk_dev} 0" since 2024 and gets a usage error on next. Could
you reword the motivation along those lines and mention total_compute?

>
> Carry a uclass id alongside the device number and resolve the block devic=
e
> with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
> partition switch on the mmc path only. "avb init <dev>" still means mmc,
> "avb init <interface> <dev>" selects another bus, and both now look the
> device up before allocating. get_boot_interface() returns UCLASS_INVALID
> without ops, so a caller that skipped "avb init" fails rather than readin=
g
> mmc.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
> ---
> Changes in v2:
> - Split: the renames moved to the preceding patch
> - Put the "avb init <dev>" comment on the branch it describes, by testing
>   argc =3D=3D 2 rather than argc =3D=3D 3
> - Drop the single-use part_num and move the user-area comment next to
>   mmc_switch_part()
>
>  boot/bootmeth_android.c                |  2 +-
>  cmd/avb.c                              | 24 ++++++---
>  common/Kconfig                         |  7 ++-
>  common/avb_verify.c                    | 71 +++++++++++++++++---------
>  doc/android/avb2.rst                   |  7 ++-
>  include/avb_verify.h                   | 26 +++++++---
>  test/py/tests/test_android/test_avb.py | 28 ++++++++++
>  7 files changed, 127 insertions(+), 38 deletions(-)
>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 0db08d4f86..ae05c08488 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -443,7 +443,7 @@ static int run_avb_verification(struct bootflow *bflo=
w)
>         bool unlocked =3D false;
>         int ret;
>
> -       avb_ops =3D avb_ops_alloc(desc->devnum);
> +       avb_ops =3D avb_ops_alloc(desc->uclass_id, desc->devnum);
>         if (!avb_ops)
>                 return log_msg_ret("avb ops", -ENOMEM);
>
> diff --git a/cmd/avb.c b/cmd/avb.c
> index 8fbd48ee5a..4c1f56a33a 100644
> --- a/cmd/avb.c
> +++ b/cmd/avb.c
> @@ -16,17 +16,28 @@ static struct AvbOps *avb_ops;
>
>  int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const a=
rgv[])
>  {
> -       unsigned long mmc_dev;
> +       struct blk_desc *desc;
>
> -       if (argc !=3D 2)
> +       if (argc < 2 || argc > 3)
>                 return CMD_RET_USAGE;
>
> -       mmc_dev =3D hextoul(argv[1], NULL);
> +       /* "avb init <dev>" keeps its old meaning of mmc <dev> */
> +       if (argc =3D=3D 2)
> +               desc =3D blk_get_devnum_by_uclass_id(UCLASS_MMC,
> +                                                  hextoul(argv[1], NULL)=
);
> +       else
> +               desc =3D blk_get_devnum_by_uclass_idname(argv[1],
> +                                                      hextoul(argv[2], N=
ULL));
> +

This up-front lookup is what breaks the existing sandbox tests: with the
series, test_avb_verify, test_avb_read_rb, test_avb_is_unlocked,
test_avb_persistent_values and the new test_avb_init_interface fail with

  Can't map file 'mmc1.img': Invalid argument
     sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
  Can't find the requested device

while next gives 4 passed, 2 skipped for test_avb.py.

Sandbox mmc1 has no backing image when these tests run
(test_android/ is collected before the tests that create mmc images),
and most of them only talk to the sandbox TA, so they never needed
the device before. Would you consider keeping
"avb init" lazy: validate the interface name here, store uclass + number,
and let get_partition() resolve the device on first access as before?

That keeps the old semantics, and a missing device is still reported, by
the first partition access. Alternatively the tests would need to create
mmc1.img first.


> +       if (!desc) {
> +               printf("Can't find the requested device\n");
> +               return CMD_RET_FAILURE;
> +       }
>
>         if (avb_ops)
>                 avb_ops_free(avb_ops);
>
> -       avb_ops =3D avb_ops_alloc(mmc_dev);
> +       avb_ops =3D avb_ops_alloc(desc->uclass_id, desc->devnum);
>         if (avb_ops)
>                 return CMD_RET_SUCCESS;
>         else
> @@ -428,7 +439,7 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int fl=
ag, int argc,
>  }
>
>  static struct cmd_tbl cmd_avb[] =3D {
> -       U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
> +       U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
>         U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
>         U_BOOT_CMD_MKENT(write_rb, 3, 0, do_avb_write_rb, "", ""),
>         U_BOOT_CMD_MKENT(is_unlocked, 1, 0, do_avb_is_unlocked, "", ""),
> @@ -464,7 +475,8 @@ static int do_avb(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
>  U_BOOT_CMD(
>         avb, 29, 0, do_avb,
>         "Provides commands for testing Android Verified Boot 2.0 function=
ality",
> -       "init <dev> - initialize avb2 for <dev>\n"
> +       "init [<interface>] <dev> - initialize avb2 for hex <dev> on <int=
erface>\n"
> +       "    (mmc, nvme, usb, ...; defaults to mmc)\n"
>         "avb read_rb <num> - read rollback index at location <num>\n"
>         "avb write_rb <num> <rb> - write rollback index <rb> to <num>\n"
>         "avb is_unlocked - returns unlock status of the device\n"
> diff --git a/common/Kconfig b/common/Kconfig
> index c739225621..5590fbfdb2 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -885,9 +885,14 @@ config AVB_VERIFY
>           This option enables compilation of bootloader-dependent operati=
ons,
>           used by Android Verified Boot 2.0 library (libavb). Includes:
>           * Helpers to process strings in order to build OS bootargs.
> -         * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.c.
> +         * Helpers to access block devices, similar to
> +           drivers/fastboot/fb_mmc.c.
>           * Helpers to alloc/init/free avb ops.
>
> +         Only mmc is initialised by AVB itself. Any other interface must
> +         already be enumerated when AVB runs, either by the board code o=
r by
> +         a command such as "usb start".
> +
>  if AVB_VERIFY
>
>  config AVB_BUF_ADDR
> diff --git a/common/avb_verify.c b/common/avb_verify.c
> index fc29433c3c..b898ebb78f 100644
> --- a/common/avb_verify.c
> +++ b/common/avb_verify.c
> @@ -8,6 +8,7 @@
>  #include <cpu_func.h>
>  #include <image.h>
>  #include <malloc.h>
> +#include <mmc.h>
>  #include <part.h>
>  #include <tee.h>
>  #include <tee/optee_ta_avb.h>
> @@ -386,44 +387,68 @@ static unsigned long avb_blk_write(struct avb_blk_p=
art *part, lbaint_t start,
>                           start, sectors, tmp_buf);
>  }
>
> -static struct avb_blk_part *get_partition(AvbOps *ops, const char *parti=
tion)
> +static int avb_init_mmc(int dev_num)
>  {
> +       struct mmc *mmc;
>         int ret;
> -       u8 dev_num;
> -       int part_num =3D 0;
> -       struct avb_blk_part *part;
> -       struct blk_desc *blk;
> -
> -       part =3D malloc(sizeof(struct avb_blk_part));
> -       if (!part)
> -               return NULL;
>
> -       dev_num =3D get_boot_device(ops);
> -       part->mmc =3D find_mmc_device(dev_num);
> -       if (!part->mmc) {
> +       mmc =3D find_mmc_device(dev_num);
> +       if (!mmc) {
>                 printf("%s: no MMC device at slot %x\n", __func__, dev_nu=
m);
> -               goto err;
> +               return -ENODEV;
>         }
>
> -       ret =3D mmc_init(part->mmc);
> +       ret =3D mmc_init(mmc);
>         if (ret) {
>                 printf("%s: MMC initialization failed, err =3D %d\n",
>                        __func__, ret);
> -               goto err;
> +               return ret;
>         }
>
> -       if (IS_MMC(part->mmc)) {
> -               ret =3D mmc_switch_part(part->mmc, part_num);
> +       if (IS_MMC(mmc)) {
> +               /* Select the user area, where the GPT and our images liv=
e */
> +               ret =3D mmc_switch_part(mmc, 0);
>                 if (ret) {
>                         printf("%s: MMC part switch failed, err =3D %d\n"=
,
>                                __func__, ret);
> -                       goto err;
> +                       return ret;
>                 }
>         }
>
> -       blk =3D mmc_get_blk_desc(part->mmc);
> +       return 0;
> +}
> +
> +static struct avb_blk_part *get_partition(AvbOps *ops, const char *parti=
tion)
> +{
> +       enum uclass_id uclass_id;
> +       struct avb_blk_part *part;
> +       struct blk_desc *blk;
> +       int dev_num;
> +       int ret;
> +
> +       part =3D malloc(sizeof(struct avb_blk_part));
> +       if (!part)
> +               return NULL;
> +
> +       dev_num =3D get_boot_device(ops);
> +       uclass_id =3D get_boot_interface(ops);
> +       if (uclass_id =3D=3D UCLASS_INVALID || dev_num < 0) {
> +               printf("%s: no storage interface, run 'avb init' first\n"=
,
> +                      __func__);
> +               goto err;
> +       }
> +
> +       if (uclass_id =3D=3D UCLASS_MMC) {
> +               ret =3D avb_init_mmc(dev_num);
> +               if (ret)
> +                       goto err;
> +       }
> +
> +       blk =3D blk_get_devnum_by_uclass_id(uclass_id, dev_num);
>         if (!blk) {
> -               printf("%s: failed to obtain block descriptor\n", __func_=
_);
> +               /* Every bus but mmc must already be started when AVB run=
s */
> +               printf("%s: no %s device %d, is the bus started?\n", __fu=
nc__,
> +                      blk_get_uclass_name(uclass_id), dev_num);

A note for the doc/Kconfig text rather than the code: with the images on
virtio/NVMe/USB and the AVB TA keeping its state in eMMC RPMB, the TA's
first RPMB request becomes the first eMMC access and happens from inside
the supplicant RPC.

On next that hangs: "avb init virtio 0; avb read_rb 0"
leaves OP-TEE spinning in do_notif, the nested RPMB announcement deadlock
fixed by "optee: do not announce RPMB from within a supplicant RPC"
(currently v2 on the list). Not a bug in this series, but that
configuration only works with that fix, so it may be worth a line in
avb2.rst.

>                 goto err;
>         }
>
> @@ -433,7 +458,6 @@ static struct avb_blk_part *get_partition(AvbOps *ops=
, const char *partition)
>                 goto err;
>         }
>
> -       part->dev_num =3D dev_num;
>         part->blk =3D blk;
>
>         return part;
> @@ -1111,7 +1135,7 @@ __weak AvbIOResult avb_read_root_key_digest(AvbOps =
*ops, uint8_t *digest)
>   * AVB2.0 AvbOps alloc/initialisation/free
>   * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>   */
> -AvbOps *avb_ops_alloc(int boot_device)
> +AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
>  {
>         struct AvbOpsData *ops_data;
>
> @@ -1134,7 +1158,8 @@ AvbOps *avb_ops_alloc(int boot_device)
>         ops_data->ops.read_persistent_value =3D read_persistent_value;
>  #endif
>         ops_data->ops.get_size_of_partition =3D get_size_of_partition;
> -       ops_data->mmc_dev =3D boot_device;
> +       ops_data->uclass_id =3D uclass_id;
> +       ops_data->dev_num =3D dev_num;
>
>         return &ops_data->ops;
>  }
> diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
> index a514701241..cef49d3e0d 100644
> --- a/doc/android/avb2.rst
> +++ b/doc/android/avb2.rst
> @@ -29,6 +29,10 @@ integration in ``common/avb_verify.c`` and the platfor=
m port under
>
>  For additional details check [1]_.
>
> +Only mmc is started by AVB itself. Any other interface must already be
> +enumerated when AVB runs, either by the board code or by a command such =
as
> +``usb start``, or the partition lookup fails.
> +
>  AVB using OP-TEE (optional)
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> @@ -80,7 +84,8 @@ AVB 2.0 U-Boot shell commands
>  Provides CLI interface to invoke AVB 2.0 verification + misc. commands f=
or
>  different testing purposes::
>
> -    avb init <dev> - initialize avb 2 for <dev>
> +    avb init [<interface>] <dev> - initialize avb 2 for hex <dev> on
> +        <interface> (mmc, nvme, usb, ...; defaults to mmc)

This is the behaviour change that bites, see the test comment at the end:
the lookup probes the device (blk_get_device() -> device_probe(), and for
mmc the blk probe runs mmc_init()), whereas "avb init" used to only store
the number. Please at least state that it probes now.

>      avb read_rb <num> - read rollback index at location <num>
>      avb write_rb <num> <rb> - write rollback index <rb> to <num>
>      avb is_unlocked - returns unlock status of the device
> diff --git a/include/avb_verify.h b/include/avb_verify.h
> index 8c97adbfbf..6dbbb39a8a 100644
> --- a/include/avb_verify.h
> +++ b/include/avb_verify.h
> @@ -7,8 +7,9 @@
>  #define _AVB_VERIFY_H
>
>  #include <../lib/libavb/libavb.h>
> +#include <blk.h>
>  #include <mapmem.h>
> -#include <mmc.h>
> +#include <part.h>
>
>  #define AVB_MAX_ARGS                   1024
>  #define VERITY_TABLE_OPT_RESTART       "restart_on_corruption"
> @@ -24,7 +25,8 @@ enum avb_boot_state {
>
>  struct AvbOpsData {
>         struct AvbOps ops;
> -       int mmc_dev;
> +       enum uclass_id uclass_id;
> +       int dev_num;
>         enum avb_boot_state boot_state;
>  #ifdef CONFIG_OPTEE_TA_AVB
>         struct udevice *tee;
> @@ -33,8 +35,6 @@ struct AvbOpsData {
>  };
>
>  struct avb_blk_part {
> -       int dev_num;
> -       struct mmc *mmc;
>         struct blk_desc *blk;
>         struct disk_partition info;
>  };
> @@ -44,7 +44,7 @@ enum avb_io_type {
>         AVB_IO_WRITE
>  };
>
> -AvbOps *avb_ops_alloc(int boot_device);
> +AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
>  void avb_ops_free(AvbOps *ops);
>
>  /**
> @@ -110,10 +110,24 @@ static inline int get_boot_device(AvbOps *ops)
>         if (ops) {
>                 data =3D ops->user_data;
>                 if (data)
> -                       return data->mmc_dev;
> +                       return data->dev_num;
>         }
>
>         return -1;
>  }
>
> +/* Mirrors get_boot_device(): no ops means no interface, not a default o=
ne */
> +static inline enum uclass_id get_boot_interface(AvbOps *ops)
> +{
> +       struct AvbOpsData *data;
> +
> +       if (ops) {
> +               data =3D ops->user_data;
> +               if (data)
> +                       return data->uclass_id;
> +       }
> +
> +       return UCLASS_INVALID;
> +}
> +
>  #endif /* _AVB_VERIFY_H */
> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_=
android/test_avb.py
> index 137d83e1de..4c5b3c6f59 100644
> --- a/test/py/tests/test_android/test_avb.py
> +++ b/test/py/tests/test_android/test_avb.py
> @@ -135,3 +135,31 @@ def test_avb_persistent_values(ubman):
>
>      response =3D ubman.run_command('avb read_pvalue test 12')
>      assert response =3D=3D 'Read 12 bytes, value =3D value_value'
> +
> +
> +@pytest.mark.buildconfigspec('cmd_avb')
> +@pytest.mark.buildconfigspec('cmd_mmc')
> +def test_avb_init_interface(ubman):
> +    """Check that 'avb init' accepts an explicit interface
> +    """
> +
> +    response =3D ubman.run_command('avb init mmc %s' % str(mmc_dev))
> +    assert response =3D=3D ''

Fails on sandbox for the same mmc1.img reason, see above.

With the "avb init" behaviour sorted out, the rest works for me:
* "avb init 0" as the first eMMC access, read_rb, is_unlocked and
  "avb verify _a" pass;
* "avb init nvme 0", "avb init mmc 5" and "avb init bogus 0" fail cleanly;
* with the Android images on virtio only (the eMMC holding just RPMB),
  "avb init virtio 0; avb verify _a" passes, and "avb init 0" on the
  empty eMMC correctly fails to find vbmeta_a;

> +
> +    response =3D ubman.run_command('avb init %s' % str(mmc_dev))
> +    assert response =3D=3D ''
> +
> +
> +@pytest.mark.buildconfigspec('cmd_avb')
> +def test_avb_init_bad_device(ubman):
> +    """Check that 'avb init' rejects a device that does not exist
> +    """
> +
> +    response =3D ubman.run_command('avb init mmc ff')
> +    assert response.find("Can't find the requested device") !=3D -1
> +
> +    response =3D ubman.run_command('avb init ff')
> +    assert response.find("Can't find the requested device") !=3D -1
> +
> +    response =3D ubman.run_command('avb init nonsense 0')
> +    assert response.find("Can't find the requested device") !=3D -1
> --
> 2.43.0
>
