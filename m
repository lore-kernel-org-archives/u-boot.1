Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01663606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0g+fjnuy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gVetDdnJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W3KEL421
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFB5A4056B;
	Mon, 26 Oct 2026 08:54:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZxuDdERf2Gfx; Mon, 26 Oct 2026 08:54:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B763140441
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793004864;
	b=qi+QsM03TM0E+jrVYIGsVpawvycURxAZZ98xjiTj2g9DtgQwHhqeJJZfNAnM3Ch2avvn
	 3qQgqlO/LDoJ3WsMuMcIFmCH85yKjteGeLXCezf5tZZebrMGwsA2lSLaTGYNqDAArWCMh
	 bqDpXI1cT01ofPLJH7tvARX0kHAwbZ2r3LfgmwxK1XyJ+WfPGgW5/ypsPFdWntekqXSCa
	 5uj12zxoeTmw1yVCYMgToR1baaEKSIucJbCAwbkUZqP5ItJo0sn9IqXKTdbZ4KftB5AoV
	 fSbrv3ifXuypEe4qoU7RwqRR/iDXUSgGMFKdIuZOLOlKpqxXulERGD0Dop+k8ah1/aQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004864;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8JBg42yfzAW05l4yF+JKxAmL1b2lkqOFefKxkXWiTMo=;
	b=PIrYol7pTuePBpm0VxUptBk8/uDeZRaJ8Rb+jqa8eT/F1iLPWltvAV+bqzKEA9ZE8K1y
	 07GxulM1Ux6JdxJ/LO3P5j1QrGARVEEuqRe/jlYph7ralX0krmjYWqIDzHTGT/Odx6eBJ
	 oGLL3EeyZr42pqprfQ8E9mrgZay0acDDLAw2zB4SoRwY6I7tTFHPxuABA7c3V9TNXHgNn
	 WWtJa4EEHRg/d0KzjSS7uQJ+qsyhw5ZIvkkJF4b0x1IBZ+JdcXAw69qED0MIPVHcBTpYj
	 i38ujSS6wGcoOS6AC/80vEeiWc2PfT/CtkQ1YEnmwv7YMjvt+S87FfJMkpdTqnuKjYQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793004864;
	bh=8JBg42yfzAW05l4yF+JKxAmL1b2lkqOFefKxkXWiTMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0g+fjnuyjlaJujBaEm/CxQ7JxTiurSxl5GQ+pCqh866tLTB27kYllu9i33v+ZUS5l
	 whA5v/mzOimrf9UBdOwjIANDq5lUx2pY0ZALMAdhsA4UIBRWPaNOCrAXaQhqadfChM
	 gJH49LqTHYd2+viWvCG3pUsgEoQGWWeSImH1WKZyFF+Vj+/xiuJixGEYwnvKIrFQnD
	 wgBQaF0TW348I/x53EY0zJQMLwscmbUKDL8NhdwcZwmkdRhl0iuq+VGIl87x03xcQr
	 GJcL8NyTew2Wj7IXYP2C0HgWjI0h6BTIFrmpSxa5Snd2ZOpcc5qxthCbJLVvBBnojy
	 40rCgyTnqNdRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B763140441;
	Mon, 26 Oct 2026 08:54:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 478C14D1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FB9740049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tTvzUfrLhXHa for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 07:19:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AAF7F4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792999195;
 b=mGuIRfbv0kFL7qLK3qIpkaWu9TOYzKhh/7tgavgntuiCOQT6//gNE2uOhMHo+5kfMc2O
 ejJq3SKHURbE6YKzNW7knKlFqUUxL3CR0AxrjHv49uaNnHmb3yiagFjHBwnX8G3wb/Ti2
 5PfxhHPnPmbUeyxb+FVa2qBbaY8GkgZsuUKWHHAMLrRU72ddDjvJ2BgrT0P1OTzUpK3hd
 ykz2ucP0TcxLjpgucLV0xFN46TLffugu/ZfmJollphaiylOvqqLGcvIGleiUx3TipT5Q7
 uT6BWxoX8824AWdnEn0926cvr3lewlk9pffYbX9RTQ47zHaui065IdEfjAKzTVbLW8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792999195;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8JBg42yfzAW05l4yF+JKxAmL1b2lkqOFefKxkXWiTMo=;
 b=TwcHYwXvm1iPs+fuEY8NA4v6bWFu8h0Fc0WRvXTU5WjUYtzc1cEuuIMYitqfBNubIEO/
 t+wg8ovEUSdnTmWOjYbpI1MzbPXtZxKStUwnprgNTgWQ3nSAYCwG0OjM5yCqXi4Oa0eyH
 oiRjhioRQmUFxuLhB0ZuBAHgd2XfK+J+xnCihHSdGecgtUHo5ctSopnec094VSXQk19yC
 fKxF5h93ShCk7VGoxF8gWe/3uTdn3EufsQ8XxVlc0iKhe9Em0ZE2+73v4wLSGHhF3T3os
 WQlhi7E9hHDa18tpAOhBcAmFQAHZokMNlE3nn3vCXtd2PoHRHEfNoubfZ9Td8HzIWSw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=gVetDdnJ; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W3KEL421; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gVetDdnJ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W3KEL421
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAF7F4004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:19:53 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aSxY2222560
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8JBg42yfzAW05l4yF+JKxAmL1b2lkqOFefKxkXWiTMo=; b=gVetDdnJAxjv1QIq
 cF26kOIKyI9zJbh8rxc8HZZdMaJbTyTk2RgYiaijmCoqNhvBhvPkyf1SgNZt/wnq
 KCPLhttjUo/U6AXowlF7MyjQCUVtqZ2wi1xwcv7T4S9S2OiJlo3LNw6pwecXUuH8
 mh7OMf7z3E+TOccZjLkusJsInbEQ8b+89BWl1D7JRERbwRZsnklR7g3GRIOZRGNm
 mTF2xoBr5fxTZayBEG/Wl7XNPwZwusBXGGflSYWxS/xoW13QJwEEKo5ik99ceqcd
 U1/m7Rgay8Nv4aROk6+8yrNKkOZ/tui3vH8xrPB7SqTqrI5qpM5e/yJRmoKsIuVQ
 HUfmSQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd911e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:19:52 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-988b530df14so79575241.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 00:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792999192; cv=none;
 d=google.com; s=arc-20260327;
 b=AilXUrMf6CK2KAX2OGb8tQDr29MkztyBpG7bTmD5ISXvsym1jGaryXY3l0kQHA9/Q+
 saSxTnHbPYVByrdZqYLzQ1CtIpjPkrdkP/uDXDQfZGiwkV5fmx55wGQCffTMqFJfb4m9
 g094mkgBu1SPangl1SSDNSm7PY0YuBVO64Wj2J/t1RWX9sO1ySGHR+dXRdZ3wwhUsmTg
 VMsIc8EyheOhcsZE0vqm6m2WPQYGkp9ivI3YzBP6lfjn3Nkp52675aL90+yITwnhrMBu
 JjzNpXkvDFWqaaZEknfrzEl/13hdN1kw3LTjJ4r58bb6mBeo3Q9mGZho8XqsDoJhwiBA
 CyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8JBg42yfzAW05l4yF+JKxAmL1b2lkqOFefKxkXWiTMo=;
 fh=GKDlMD+5P3E+S7j9MXtKsi6vW3O73Ar5s2d+QJMDjMo=;
 b=OxkkgwGmNzF+BfleTd51txqTn5jGJOKO7gm3cpp7ssO4zBoC3MdPgFS046uqTWXf0H
 3BCPbJhCxKLICjM55TTL69i1PuEIBblIgZ/xXlVvP8MsWwoPwsycTQ4UWXdx9oDPVJzi
 x45Ja84L6wnfKqztfu9LBFqFTPs7vv32Xwrj38twqxxG9hdayQG3bAGsDsmoI1kqkqug
 P6TFR4CTR6LcIvIIDrKM7E/bVg+VKKHUI4G3WtYbbcCK/hi8JSm9rmTJKqctg72YNoKF
 6FmGNAqO2Ut9r2AxlDGn5AcJAFhKW4sHWi4P0Y8F07J5OBYAwuANORyP97caBhnx+qKs
 X/SA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792999192; x=1793603992;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8JBg42yfzAW05l4yF+JKxAmL1b2lkqOFefKxkXWiTMo=;
 b=W3KEL421Cc6VBmpO9e1PDsJ6ii8a5cbMFyNtF4xfQULVXCNm2jq5ii/iIRRMzddgzf
 HCSvcpGR8OHZ4zFZrPTel6QHnXjVhqyvzgE342VdprCC+dUFnWHJavElQKU9IIIrfOuW
 kYQV0rOMJih5GZQCQnJotlY6gPF0BHL/oqTGhuY5DI2QcD1uhPSb74buJGsUcQf9szEd
 QkQ7kLHxErKe4J/E36ZrYjvwks4orzplj5f6A4LrRKPG+H9ReReFTdffTypgcf+0qDFy
 CEHnSPWGIC7H/EHD1ghVsTd06iR2N+7+9zA0TMNsy+BkNXPCpFGB6O8rLUBWdIWwDRH5
 D6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792999192; x=1793603992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8JBg42yfzAW05l4yF+JKxAmL1b2lkqOFefKxkXWiTMo=;
 b=snRJIMKq6RkZvirkYY/sx7U623jprJPu5wWj2W1OVhtvRQfL7s+J+Bv3F3pTua0UN6
 LSyqKuIo+EkyHQzYVCqE5ayiw5rKFm20ZztsSbySg/sskedHm71VqR78ry9CJIJFL9km
 yVeHDNIbEF2Ha02f48NZOnRe0zpq+ULjebEvNRzUhC4sbgictAlejs7gJTQnWCYoxcrm
 GfJKfptxX/sTaLrI+PXJfZG5pHt6+llv/GTSAon1Md3y3rCYzsQXPKi7GJgzalCDWyi4
 JbyYNglefWah2uxwt7xqF0Wq8Pj2FrUxAlBrZfcpK2F63RFmp/ag0vwEGchcycsq0yvY
 GzAw==
X-Gm-Message-State: AFq9FYKOcMiPMVoYHlRjv7aBssPRNMOXCCblldqXkbxWJ37uluRbwMEn
 VEswrgJrarYWjN9UfGaci/xsEej09hbUkMOy6hB2ghvLQz3e5ag/JPn9spso9Lt2qOfRIeOjEbS
 dfFTrxutn/yBQEkZ3qJBHZLxBw182WGoavu2QpFmldvtOmfuOmIzAlzgRs1qa6lxEAd8Wl6xBb4
 jHoxoD30W5u78j3JCzd+b4Lc29a1lXqMiTB0PHSnhhTqRcWA==
X-Gm-Gg: AYBFou3y73tQILwBTu/5iJRBwOPIpFuAdC0SqcrS+D7J+KQu/YvMyNuGT8t90oKvg+B
 TEqIQPIcjq2iUP6m0ErG3YYoe8VP/KRiKaNGc/Vz/GlkWiZxRxyshagrw+lW73v9PdgI7UDHW0X
 DNJC1yhd33XvwJihtpj1u00fNr5yIlPkWHHjZk6v98qWsXdEUuNnE1sVzYyoo=
X-Received: by 2002:a05:6123:4201:20b0:5ea:b7b5:454 with SMTP id
 71dfb90a1353d-5ec230af32bmr1089626e0c.1.1792999191666; 
 Mon, 26 Oct 2026 00:19:51 -0700 (PDT)
X-Received: by 2002:a05:6123:4201:20b0:5ea:b7b5:454 with SMTP id
 71dfb90a1353d-5ec230af32bmr1089619e0c.1.1792999191057; Mon, 26 Oct 2026
 00:19:51 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-5-d53d34a49780@microchip.com>
In-Reply-To: <20261014-rpmi_v4-v4-5-d53d34a49780@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 12:49:39 +0530
X-Gm-Features: AclHuK_uqSWOdMwD-oOkMrUMJ_fWCLExQtsAcsSlmdrqqTNToMGpM5c7qi37d7Y
Message-ID: <CAPxK-6dAV__Pu4ACk+GNK6kXZUcWvp1jUpNd-7-E_ysCs1=18g@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] firmware: rpmi: add a test and a sandbox driver
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: FvAZxG2ApTDEFr8ob8ZLo8t827RTM808
X-Proofpoint-GUID: FvAZxG2ApTDEFr8ob8ZLo8t827RTM808
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfX97UdJcsvTj+k
 wSCtatpRmApoCtp2xYrC44qUjElMaDBjP3eqWlchsY3W10LRR5bMBbs2R9syGBcSW1Um36OXuVt
 K6iaSIqURNWlQ/oWI2wEcX4rxWn2tL8v2JAeXbfNQFHl4s5GRsT2TuP3ekn2TEzb5+eqvXULNIP
 s4tBgd6O9TF71Vphdvde2LFINBNvWL058i0aKY/fN0BalpNk1EqsR5x8c5EfieTVVIBPH02/0WV
 a3yKTEa78P0hLkQrUX/NnPSGCopn9S2oN8GYD0gwdipxGNUO+3i5fKGS2pijy2YamUGmTc+puRR
 jI96Li/acdqZELcNYXz2CJMvG19E535rC+8V1aWFeBEJGXhOe1YLKMwvA3svO+aGlKVXjUphs/i
 1FIIXuOP6r9L+2ZsVaaPETSt83z9b3CQ8WdZFeYpVqrubLb5t6ua4XKMl8U/1u/15J9HpEC6UBM
 a22G5jMcgazH0yBk8xA==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adeff18 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=hwM_GrIuAAAA:20 a=XYAwZIGsAAAA:8 a=cm27Pg_UAAAA:8
 a=5tfQG9h9EYcjhB-HkSAA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
 a=E8ToXWR_bxluHZ7gmE-Z:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyOCBTYWx0ZWRfXzh0z3pUEF335
 Ox+3Q+DPJVX9hvQvqbAOeotnxvYjJbZ38x/DxIp7faRqPJg3uTI1hRJiwQNysh5uGcuSkcN/fr/
 iCtntx++4dTF0kg3p5jHVAAPmaABECk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260028
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:54:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Charles,

On Wed, Oct 14, 2026 at 7:47=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> Create a new transport layer that sends the messages to a simulated RPMI
> firmware.
>
> For now, this only contains a simulation of the clock service group
> which is implemented using code from librpmi [1] and adapted.
>
> Also add a test in test/dm that makes use of the RPMI clock driver.
>
> [1]:
> https://github.com/riscv-software-src/librpmi/blob/3f3c4ca47339a8795432e2=
60f17e1fc5091c9a3a/lib/rpmi_service_group_clock.c
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v4: None
> Changes in v3: None
>
> Changes in v2:
>  - Reorder headers
> ---
>  MAINTAINERS                                |   1 +
>  arch/sandbox/dts/test.dts                  |  12 +
>  configs/sandbox_defconfig                  |   2 +
>  drivers/firmware/rpmi/Kconfig              |   3 +-
>  drivers/firmware/rpmi/Makefile             |   1 +
>  drivers/firmware/rpmi/rpmi-sandbox-clock.c | 446 +++++++++++++++++++++++=
++++++
>  drivers/firmware/rpmi/rpmi-sandbox.c       | 156 ++++++++++
>  drivers/firmware/rpmi/rpmi-sandbox.h       |  47 +++
>  test/dm/Makefile                           |   1 +
>  test/dm/rpmi.c                             |  48 ++++
>  10 files changed, 716 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf45df9a027a..6ca7709c64b7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1564,6 +1564,7 @@ S:        Maintained
>  F:     drivers/clk/clk_rpmi.c
>  F:     drivers/firmware/rpmi/
>  F:     include/rpmi*
> +F:     test/dm/rpmi.c
>
>  SANDBOX
>  M:     Simon Glass <sjg@chromium.org>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index 25c99ef81472..d7998fa0da4a 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -882,6 +882,18 @@
>                 sm: secure-monitor {
>                         compatible =3D "sandbox,sm";
>                 };
> +
> +               rpmi: rpmi {
> +                       compatible =3D "sandbox,rpmi-transport";
> +                       #mbox-cells =3D <1>;
> +               };
> +
> +               rpmi_clock: rpmi-clock {
> +                       compatible =3D "riscv,rpmi-clock";
> +                       mboxes =3D <&rpmi 0x8>;
> +                       #clock-cells =3D <1>;
> +                       clocks =3D <&rpmi_clock 0>, <&rpmi_clock 1>, <&rp=
mi_clock 2>, <&rpmi_clock 3>;
> +               };
>         };
>
>         fpga {
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index a2708e6fb333..52df7cc08b14 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -198,6 +198,7 @@ CONFIG_BUTTON_GPIO=3Dy
>  CONFIG_CLK=3Dy
>  CONFIG_CLK_K210=3Dy
>  CONFIG_CLK_K210_SET_RATE=3Dy
> +CONFIG_CLK_RPMI=3Dy
>  CONFIG_SANDBOX_CLK_CCF=3Dy
>  CONFIG_CLK_SCMI=3Dy
>  CONFIG_CPU=3Dy
> @@ -214,6 +215,7 @@ CONFIG_FASTBOOT_FLASH=3Dy
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=3D0
>  CONFIG_ARM_FFA_TRANSPORT=3Dy
>  CONFIG_SCMI_FIRMWARE=3Dy
> +CONFIG_RPMI_FIRMWARE=3Dy
>  CONFIG_FPGA_ALTERA=3Dy
>  CONFIG_FPGA_STRATIX_II=3Dy
>  CONFIG_FPGA_STRATIX_V=3Dy
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index 421a1fa9deba..b462d3693987 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -1,6 +1,7 @@
>  config RPMI_FIRMWARE
>         bool "Enable RPMI support"
> -       depends on RISCV && DM && OF_CONTROL
> +       depends on RISCV || SANDBOX
> +       depends on DM && OF_CONTROL
>         select FIRMWARE
>         help
>           RISC-V Platform Management Interface (RPMI) defines an OS-agnos=
tic
> diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makef=
ile
> index 4f4bcb929db4..150e98a72df9 100644
> --- a/drivers/firmware/rpmi/Makefile
> +++ b/drivers/firmware/rpmi/Makefile
> @@ -1,3 +1,4 @@
>  obj-y  +=3D rpmi-uclass.o
>  obj-$(CONFIG_RPMI_SBI_MPXY) +=3D rpmi-sbi-mpxy.o
>  obj-$(CONFIG_RPMI_SHMEM) +=3D rpmi-shmem.o
> +obj-$(CONFIG_SANDBOX)  +=3D rpmi-sandbox.o rpmi-sandbox-clock.o
> diff --git a/drivers/firmware/rpmi/rpmi-sandbox-clock.c b/drivers/firmwar=
e/rpmi/rpmi-sandbox-clock.c
> new file mode 100644
> index 000000000000..fa205d067b24
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sandbox-clock.c
> @@ -0,0 +1,446 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Ventana Micro Systems Inc.
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <asm/types.h>
> +#include <asm/io.h>
> +#include <asm/byteorder.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <rpmi.h>
> +#include "rpmi-sandbox.h"
> +
> +struct rpmi_clock {
> +       enum rpmi_clock_type type;
> +       const char *name;
> +       u32 rate_count;
> +       const u64 *rate_array;
> +       u32 transition_latency;
> +       enum rpmi_clock_state state;
> +       u64 rate;
> +};
> +
> +const u64 discrete_rates[] =3D { 20000000, 333333333, 500000000, 1000000=
000 };
> +
> +const u64 linear_rates[] =3D { 50000000, 100000000, 1000000 };
> +
> +#define DISCRETE_CLOCK(name, current_state, current_rate) \
> +       { RPMI_CLK_TYPE_DISCRETE,                         \
> +         name,                                           \
> +         ARRAY_SIZE(discrete_rates),                     \
> +         discrete_rates,                                 \
> +         0,                                              \
> +         current_state,                                  \
> +         current_rate }
> +
> +#define LINEAR_CLOCK(name, current_state, current_rate)         \
> +       { RPMI_CLK_TYPE_LINEAR, name, ARRAY_SIZE(linear_rates), \
> +         linear_rates,         0,    current_state,            \
> +         current_rate }
> +
> +struct rpmi_clock clock_simulation[] =3D {
> +       DISCRETE_CLOCK("CLK0", RPMI_CLK_STATE_DISABLED, discrete_rates[0]=
),
> +       DISCRETE_CLOCK("CLK1", RPMI_CLK_STATE_DISABLED, discrete_rates[1]=
),
> +       DISCRETE_CLOCK("CLK2", RPMI_CLK_STATE_ENABLED, discrete_rates[2])=
,
> +       LINEAR_CLOCK("CLK3", RPMI_CLK_STATE_ENABLED, linear_rates[0]),
> +};
> +
> +static u32 clock_count =3D ARRAY_SIZE(clock_simulation);
> +
> +static struct rpmi_clock *rpmi_get_clock(u32 clkid)
> +{
> +       if (clkid >=3D clock_count)
> +               return NULL;
> +
> +       return &clock_simulation[clkid];
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_set_rate(u32 clkid, enum rpmi_clock_rate_match match, u64 rat=
e)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       clk->rate =3D rate;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes rpmi_clock_set_state(u32 clkid,
> +                                                 enum rpmi_clock_state s=
tate)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       clk->state =3D state;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes rpmi_clock_get_state(u32 clkid,
> +                                                 enum rpmi_clock_state *=
state)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk || !state)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       *state =3D clk->state;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes rpmi_clock_get_rate(u32 clkid, u64 *rate)
> +{
> +       struct rpmi_clock *clk =3D rpmi_get_clock(clkid);
> +
> +       if (!clk || !rate)
> +               return RPMI_ERR_INVALID_PARAM;
> +
> +       *rate =3D clk->rate;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_num_clocks(struct rpmi_transport *trans, u16 request_d=
atalen,
> +                            const u8 *request_data, u16 *response_datale=
n,
> +                            u8 *response_data)
> +{
> +       u32 *resp =3D (void *)response_data;
> +
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +       resp[1] =3D cpu_to_le32(clock_count);
> +
> +       *response_datalen =3D 2 * sizeof(*resp);
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_attributes(struct rpmi_transport *trans, u16 request_d=
atalen,
> +                            const u8 *request_data, u16 *response_datale=
n,
> +                            u8 *response_data)
> +{
> +       struct rpmi_clock *clk;
> +       u16 resp_dlen;
> +       u32 flags =3D 0;
> +
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       clk =3D rpmi_get_clock(clkid);
> +       if (!clk) {
> +               resp_dlen =3D sizeof(*resp);
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       /* encode CLOCK_FORMAT */
> +       if (clk->type =3D=3D RPMI_CLK_TYPE_LINEAR)
> +               flags |=3D 1;
> +
> +       resp[3] =3D cpu_to_le32(clk->transition_latency);
> +       resp[2] =3D cpu_to_le32(clk->rate_count);
> +       resp[1] =3D cpu_to_le32(flags);
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +
> +       if (clk->name)
> +               strlcpy((char *)&resp[4], clk->name, RPMI_CLK_NAME_LEN);
> +
> +       resp_dlen =3D 8 * sizeof(*resp);
> +
> +done:
> +       *response_datalen =3D resp_dlen;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_supp_rates(struct rpmi_transport *trans, u16 request_d=
atalen,
> +                            const u8 *request_data, u16 *response_datale=
n,
> +                            u8 *response_data)
> +{
> +       u32 i =3D 0, j =3D 0;
> +       u32 rate_count;
> +       u32 resp_dlen =3D 0, clk_rate_idx =3D 0;
> +       u32 max_rates, remaining =3D 0, returned =3D 0;
> +       const u64 *rate_array;
> +       struct rpmi_clock *clk;
> +
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       clk =3D rpmi_get_clock(clkid);
> +       if (clk) {
> +               resp_dlen =3D sizeof(*resp);
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
 This condition is inverted: a valid clock ID returns
 `RPMI_ERR_INVALID_PARAM`, while an invalid ID leaves `clk =3D=3D NULL` and=
 is
 dereferenced on the next line. Please change this to `if (!clk)`.

> +
> +       rate_count =3D clk->rate_count;
> +       rate_array =3D clk->rate_array;
> +       if (!rate_count || !rate_array) {
> +               resp_dlen =3D sizeof(*resp);
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_NOTSUPP);
> +               goto done;
> +       }
> +
> +       clk_rate_idx =3D cpu_to_le32(((const u32 *)request_data)[1]);
> +
> +       if (clk->type =3D=3D RPMI_CLK_TYPE_LINEAR) {
> +               /* max, min and step */
> +               for (i =3D 0; i < 3; i++) {
> +                       resp[4 + 2 * i] =3D cpu_to_le32((u32)(rate_array[=
i]));
> +                       resp[5 + 2 * i] =3D
> +                               cpu_to_le32((u32)(rate_array[i] >> 32));
> +               }
> +               remaining =3D 0;
> +               returned =3D 3;
> +       } else if (clk->type =3D=3D RPMI_CLK_TYPE_DISCRETE) {
> +               if (clk_rate_idx > rate_count) {
> +                       resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PAR=
AM);
> +                       resp_dlen =3D sizeof(*resp);
> +                       goto done;
> +               }
> +
> +               /* max rates a rpmi message can accommodate */
> +               max_rates =3D (trans->msg_data_size - (4 * sizeof(*resp))=
) /
> +                           sizeof(u64);
> +               remaining =3D rate_count - clk_rate_idx;
> +               if (remaining > max_rates)
> +                       returned =3D max_rates;
> +               else
> +                       returned =3D remaining;
> +
> +               for (i =3D clk_rate_idx, j =3D 0;
> +                    i <=3D (clk_rate_idx + returned - 1); i++, j++) {
> +                       resp[4 + 2 * j] =3D cpu_to_le32((u32)(rate_array[=
i]));
> +                       resp[5 + 2 * j] =3D
> +                               cpu_to_le32((u32)(rate_array[i] >> 32));
> +               }
> +
> +               remaining =3D rate_count - (clk_rate_idx + returned);
> +       } else {
> +               return RPMI_ERR_FAILED;
> +       }
> +
> +       resp[3] =3D cpu_to_le32((u32)returned);
> +       resp[2] =3D cpu_to_le32((u32)remaining);
> +       /* No flags currently supported */
> +       resp[1] =3D cpu_to_le32(0);
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +
> +       resp_dlen =3D (4 * sizeof(*resp)) + (returned * sizeof(u64));
> +
> +done:
> +       *response_datalen =3D resp_dlen;
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_set_config(struct rpmi_transport *trans, u16 request_datal=
en,
> +                        const u8 *request_data, u16 *response_datalen,
> +                        u8 *response_data)
> +{
> +       enum rpmi_error_codes status;
> +       u32 cfg, new_state;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       cfg =3D cpu_to_le32(((const u32 *)request_data)[1]);
> +
> +       /* get command from 0th index bit in config field */
> +       new_state =3D (cfg & 0b1) ? RPMI_CLK_STATE_ENABLED :
> +                                 RPMI_CLK_STATE_DISABLED;
> +
> +       /* change clock config synchronously */
> +       status =3D rpmi_clock_set_state(clkid, new_state);
> +       resp[0] =3D cpu_to_le32((u32)status);
> +
> +done:
> +       *response_datalen =3D sizeof(*resp);
> +
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_config(struct rpmi_transport *trans, u16 request_datal=
en,
> +                        const u8 *request_data, u16 *response_datalen,
> +                        u8 *response_data)
> +{
> +       u16 resp_dlen;
> +       enum rpmi_error_codes status;
> +       enum rpmi_clock_state state;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       status =3D rpmi_clock_get_state(clkid, &state);
> +       if (status) {
> +               resp[0] =3D cpu_to_le32((u32)status);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       /** RPMI config field only return enabled or disabled state */
> +       state =3D (state =3D=3D RPMI_CLK_STATE_ENABLED) ? 1 : 0;
> +
> +       resp[1] =3D cpu_to_le32((u32)state);
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +
> +       resp_dlen =3D 2 * sizeof(*resp);
> +
> +done:
> +       *response_datalen =3D resp_dlen;
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_set_rate(struct rpmi_transport *trans, u16 request_datalen=
,
> +                      const u8 *request_data, u16 *response_datalen,
> +                      u8 *response_data)
> +{
> +       enum rpmi_error_codes status;
> +       enum rpmi_clock_rate_match rate_match;
> +       u32 flags;
> +       u32 rate_low, rate_hi;
> +       u64 rate_u64;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       flags =3D cpu_to_le32(((const u32 *)request_data)[1]);
> +
> +       /* get rate match mode from flags */
> +       rate_match =3D flags & 0b11;
> +       if (rate_match >=3D RPMI_CLK_RATE_MATCH_MAX) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       rate_low =3D cpu_to_le32(((const u32 *)request_data)[2]);
> +       rate_hi =3D cpu_to_le32(((const u32 *)request_data)[3]);
> +
> +       rate_u64 =3D ((u64)rate_hi << 32) | rate_low;
> +       if (rate_u64 =3D=3D RPMI_CLOCK_RATE_INVALID || rate_u64 =3D=3D 0)=
 {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               goto done;
> +       }
> +
> +       status =3D rpmi_clock_set_rate(clkid, rate_match, rate_u64);
> +       resp[0] =3D cpu_to_le32((u32)status);
> +
> +done:
> +       *response_datalen =3D sizeof(*resp);
> +       return RPMI_SUCCESS;
> +}
> +
> +static enum rpmi_error_codes
> +rpmi_clock_sg_get_rate(struct rpmi_transport *trans, u16 request_datalen=
,
> +                      const u8 *request_data, u16 *response_datalen,
> +                      u8 *response_data)
> +{
> +       u16 resp_dlen;
> +       enum rpmi_error_codes status;
> +       u64 rate_u64;
> +       u32 *resp =3D (void *)response_data;
> +
> +       u32 clkid =3D cpu_to_le32(((const u32 *)request_data)[0]);
> +
> +       if (clkid >=3D clock_count) {
> +               resp[0] =3D cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       status =3D rpmi_clock_get_rate(clkid, &rate_u64);
> +       if (status) {
> +               resp[0] =3D cpu_to_le32((u32)status);
> +               resp_dlen =3D sizeof(*resp);
> +               goto done;
> +       }
> +
> +       resp[2] =3D cpu_to_le32((u32)(rate_u64 >> 32));
> +       resp[1] =3D cpu_to_le32((u32)(rate_u64));
> +       resp[0] =3D cpu_to_le32((u32)RPMI_SUCCESS);
> +
> +       resp_dlen =3D 3 * sizeof(*resp);
> +
> +done:
> +       *response_datalen =3D resp_dlen;
> +       return RPMI_SUCCESS;
> +}
> +
> +static const struct rpmi_service rpmi_clock_services[RPMI_CLK_SRV_ID_MAX=
_COUNT] =3D {
> +       [RPMI_CLK_SRV_GET_NUM_CLOCKS] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_NUM_CLOCKS,
> +               .min_a2p_request_datalen =3D 0,
> +               .process_a2p_request =3D rpmi_clock_sg_get_num_clocks,
> +       },
> +       [RPMI_CLK_SRV_GET_ATTRIBUTES] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_ATTRIBUTES,
> +               .min_a2p_request_datalen =3D 4,
> +               .process_a2p_request =3D rpmi_clock_sg_get_attributes,
> +       },
> +       [RPMI_CLK_SRV_GET_SUPPORTED_RATES] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_SUPPORTED_RATES,
> +               .min_a2p_request_datalen =3D 8,
> +               .process_a2p_request =3D rpmi_clock_sg_get_supp_rates,
> +       },
> +       [RPMI_CLK_SRV_SET_CONFIG] =3D {
> +               .service_id =3D RPMI_CLK_SRV_SET_CONFIG,
> +               .min_a2p_request_datalen =3D 8,
> +               .process_a2p_request =3D rpmi_clock_sg_set_config,
> +       },
> +       [RPMI_CLK_SRV_GET_CONFIG] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_CONFIG,
> +               .min_a2p_request_datalen =3D 4,
> +               .process_a2p_request =3D rpmi_clock_sg_get_config,
> +       },
> +       [RPMI_CLK_SRV_SET_RATE] =3D {
> +               .service_id =3D RPMI_CLK_SRV_SET_RATE,
> +               .min_a2p_request_datalen =3D 16,
> +               .process_a2p_request =3D rpmi_clock_sg_set_rate,
> +       },
> +       [RPMI_CLK_SRV_GET_RATE] =3D {
> +               .service_id =3D RPMI_CLK_SRV_GET_RATE,
> +               .min_a2p_request_datalen =3D 4,
> +               .process_a2p_request =3D rpmi_clock_sg_get_rate,
> +       },
> +};
> +
> +const struct rpmi_service_group rpmi_sandbox_clock_sg =3D {
> +       .name =3D "clk",
> +       .max_service_id =3D RPMI_CLK_SRV_GET_RATE,
> +       .servicegroup_version =3D RPMI_MKVER(1, 0),
> +       .services =3D rpmi_clock_services,
> +};
> diff --git a/drivers/firmware/rpmi/rpmi-sandbox.c b/drivers/firmware/rpmi=
/rpmi-sandbox.c
> new file mode 100644
> index 000000000000..5597c27067eb
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sandbox.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <dm.h>
> +#include <log.h>
> +#include <rpmi-uclass.h>
> +#include <dm/device_compat.h>
> +
> +#include "rpmi-sandbox.h"
> +
> +#define RPMI_SANDBOX_MIN_SLOT_SIZE 64
> +#define RPMI_SANDBOX_SHMEM_HEADER_SIZE 8
> +#define RPMI_SANDBOX_MAX_MSG_SIZE \
> +       (RPMI_SANDBOX_MIN_SLOT_SIZE - RPMI_SANDBOX_SHMEM_HEADER_SIZE)
> +
> +#define DRIVER_NAME "rpmi-sandbox"
> +#define DRIVER_NAME_LEN (sizeof(DRIVER_NAME))
> +
> +struct rpmi_sandbox {
> +       struct udevice *dev;
> +};
> +
> +const struct rpmi_service_group *rpmi_sandbox_sg(u32 servicegroup_id)
> +{
> +       switch (servicegroup_id) {
> +       case RPMI_SRVGRP_CLOCK:
> +               return &rpmi_sandbox_clock_sg;
> +       default:
> +               return NULL;
> +       }
> +}
> +
> +static int rpmi_sandbox_get_attr(struct rpmi_chan *chan,
> +                                enum rpmi_attribute_id id, u32 *data)
> +{
> +       const struct rpmi_service_group *sg =3D rpmi_sandbox_sg(chan->id)=
;
> +
> +       if (!sg)
> +               return -EOPNOTSUPP;
> +
> +       switch (id) {
> +       case RPMI_ATTR_SPEC_VERSION:
> +               *data =3D RPMI_MKVER(1, 0);
> +               break;
> +       case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> +               *data =3D RPMI_SANDBOX_MAX_MSG_SIZE;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_ID:
> +               *data =3D chan->id;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_VERSION:
> +               *data =3D sg->servicegroup_version;
> +               break;
> +       case RPMI_ATTR_IMPL_ID:
> +               *data =3D 0;
> +               break;
> +       case RPMI_ATTR_IMPL_VERSION:
> +               *data =3D RPMI_MKVER(1, 0);
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_sandbox_request(struct rpmi_chan *chan, u32 service_id,
> +                               const void *request, unsigned long reques=
t_len,
> +                               void *response, unsigned long max_respons=
e_len,
> +                               unsigned long *out_response_len)
> +{
> +       const struct rpmi_service_group *sg =3D rpmi_sandbox_sg(chan->id)=
;
> +       const struct rpmi_service *service;
> +       u8 slot[RPMI_SANDBOX_MAX_MSG_SIZE];
> +       struct rpmi_transport trans =3D {
> +               .msg_data_size =3D sizeof(slot),
> +       };
> +       u16 response_data_len =3D 0;
> +       enum rpmi_error_codes err;
> +
> +       if (!sg)
> +               return -EOPNOTSUPP;
> +
> +       if (service_id > sg->max_service_id)
> +               return -EOPNOTSUPP;
> +
> +       service =3D &sg->services[service_id];
> +
> +       if (!service)
> +               return -EOPNOTSUPP;
> +
> +       if (request_len < service->min_a2p_request_datalen)
> +               return -EINVAL;
> +
> +       if (!service->process_a2p_request)
> +               return -ENOSYS;
> +
> +       err =3D service->process_a2p_request(&trans, request_len, request=
,
> +                                          &response_data_len, slot);
> +
> +       if (err)
> +               return rpmi_to_linux_error(err);
> +
> +       if (out_response_len)
> +               *out_response_len =3D response_data_len;
> +
> +       if (response)
> +               memcpy(response, slot,
> +                      min(max_response_len, (unsigned long)response_data=
_len));
> +
> +       return 0;
> +}
> +
> +static int rpmi_sandbox_of_xlate(struct rpmi_chan *chan,
> +                                struct ofnode_phandle_args *args)
> +{
> +       if (args->args_count !=3D 1)
> +               return -EINVAL;
> +
> +       chan->id =3D args->args[0];
> +
> +       return 0;
> +}
> +
> +static int rpmi_sandbox_probe(struct udevice *dev)
> +{
> +       struct rpmi_sandbox *priv =3D dev_get_priv(dev);
> +
> +       priv->dev =3D dev;
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id rpmi_sandbox_ids[] =3D {
> +       { .compatible =3D "sandbox,rpmi-transport" },
> +       {}
> +};
> +
> +static const struct rpmi_transport_ops rpmi_sandbox_ops =3D {
> +       .of_xlate =3D rpmi_sandbox_of_xlate,
> +       .get_attr =3D rpmi_sandbox_get_attr,
> +       .request =3D rpmi_sandbox_request,
> +};
> +
> +U_BOOT_DRIVER(rpmi_sandbox) =3D {
> +       .name =3D "rpmi-sandbox",
> +       .id =3D UCLASS_RPMI,
> +       .of_match =3D rpmi_sandbox_ids,
> +       .probe =3D rpmi_sandbox_probe,
> +       .priv_auto =3D sizeof(struct rpmi_sandbox),
> +       .ops =3D &rpmi_sandbox_ops,
> +};
> diff --git a/drivers/firmware/rpmi/rpmi-sandbox.h b/drivers/firmware/rpmi=
/rpmi-sandbox.h
> new file mode 100644
> index 000000000000..132d1e9e8be6
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sandbox.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#ifndef _RPMI_SANDBOX_H
> +#define _RPMI_SANDBOX_H
> +
> +#include <stdbool.h>
> +#include <asm/types.h>
> +#include <rpmi.h>
> +
> +struct rpmi_transport {
> +       int msg_data_size;
> +};
> +
> +struct rpmi_service {
> +       /** ID of the service */
> +       u8 service_id;
> +
> +       /** Minimum data length for handling request */
> +       u16 min_a2p_request_datalen;
> +
> +       /** Callback to process a2p request */
> +       enum rpmi_error_codes (*process_a2p_request)(
> +               struct rpmi_transport *trans, u16 request_data_len,
> +               const u8 *request_data, u16 *response_data_len,
> +               u8 *response_data);
> +};
> +
> +struct rpmi_service_group {
> +       /** Name of the service group */
> +       const char *name;
> +
> +       /** Maximum service ID of the service group */
> +       int max_service_id;
> +
> +       /** Service group version */
> +       u32 servicegroup_version;
> +
> +       /** Array of services indexed by service ID */
> +       const struct rpmi_service *services;
> +};
> +
> +extern const struct rpmi_service_group rpmi_sandbox_clock_sg;
> +
> +#endif
> diff --git a/test/dm/Makefile b/test/dm/Makefile
> index 5dd6b57bbe84..c6372fa40583 100644
> --- a/test/dm/Makefile
> +++ b/test/dm/Makefile
> @@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_RKMTD) +=3D rkmtd.o
>  obj-$(CONFIG_$(PHASE_)DM_RNG) +=3D rng.o
>  obj-$(CONFIG_DM_RTC) +=3D rtc.o
>  obj-$(CONFIG_SCMI_FIRMWARE) +=3D scmi.o
> +obj-$(CONFIG_RPMI_FIRMWARE) +=3D rpmi.o
>  obj-$(CONFIG_SCSI) +=3D scsi.o
>  obj-$(CONFIG_DM_SERIAL) +=3D serial.o
>  obj-$(CONFIG_DM_SPI_FLASH) +=3D sf.o
> diff --git a/test/dm/rpmi.c b/test/dm/rpmi.c
> new file mode 100644
> index 000000000000..7cb4fd11a46d
> --- /dev/null
> +++ b/test/dm/rpmi.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#include <clk.h>
> +#include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/test.h>
> +#include <rpmi.h>
> +#include <stdio.h>
> +#include <test/ut.h>
> +
> +static int dm_test_rpmi_clock(struct unit_test_state *uts)
> +{
> +       struct udevice *rpmi_dev, *clk_dev;
> +       struct clk clk0, clk1, clk2, clk3;
> +
> +       ut_assertok(uclass_get_device_by_name(UCLASS_RPMI, "rpmi", &rpmi_=
dev));
> +
> +       ut_assertok(
> +               uclass_get_device_by_name(UCLASS_CLK, "rpmi-clock", &clk_=
dev));
> +
> +       // Grab clock 0 and retrieve the rate
> +       ut_assertok(clk_get_by_index(clk_dev, 0, &clk0));
> +       ut_asserteq_64(20000000, clk_get_rate(&clk0));
> +
> +       // Change to 1GHz
> +       ut_asserteq(1000000000, clk_set_rate(&clk0, 1000000000));

 The test does not exercise the supported-rates path above. Please add a
 regression test that sends `GET_SUPPORTED_RATES` through the sandbox trans=
port
 for both a valid clock ID and an out-of-range ID. The current get-rate/set=
-rate
 test passes without invoking this service. Enable/disable coverage can be
 added separately; shared-memory and MPXY command tests belong with their
 respective transport/command harnesses.

 Regards,
 Subrahmanya

> +
> +       // Revert back to 200MHz
> +       ut_asserteq(20000000, clk_set_rate(&clk0, 20000000));
> +
> +       // Grab clock 1
> +       ut_assertok(clk_get_by_index(clk_dev, 1, &clk1));
> +       ut_asserteq_64(333333333, clk_get_rate(&clk1));
> +
> +       // Grab clock 2
> +       ut_assertok(clk_get_by_index(clk_dev, 2, &clk2));
> +       ut_asserteq_64(500000000, clk_get_rate(&clk2));
> +
> +       // Grab clock 3
> +       ut_assertok(clk_get_by_index(clk_dev, 3, &clk3));
> +       ut_asserteq_64(50000000, clk_get_rate(&clk3));
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_rpmi_clock, UTF_SCAN_FDT);
>
> --
> 2.53.0
>
