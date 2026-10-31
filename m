Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2B606A321
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EB/5RnSK;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cKNVOq0j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C473F60656;
	Sat, 31 Oct 2026 09:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yKNRRj087R4o; Sat, 31 Oct 2026 09:30:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20E1160667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439015;
	b=GMeRL4OsHZDAROOGh7B2UkbCbTvyX1yy2QinDj10JrzfSJcA7VGO5zIDe1h42ENc3SSM
	 04XX1Fwh0hf6Smrkm8KOKt2r5NxYjWO8q92TX0pwR1Kkyjv+/j/S4Rzc+x7sW2yflDpXV
	 CcZBci6Fx2Qc9rXm7M6Q57w/IX30gyrSD9fRvjWYlcOIJCAoYh2KSnLmbUm1HOmK4/D6h
	 uT/fGmYEymW7V3sPO9ZK50W5oARCiJUzPpO2pe6oaCOMOb5byFfqWWhFby/oueYUOm2Xk
	 WLyJqaJ1ZhkZnzrXaE6lu+EA3IENOSZ8fAUFWgjoCYnDBk8atVBGKAW2srjeZ7XeyWg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xJOeu0GVrgf57r4Xw0st2evRWSL8On+FoVFT3m37TkY=;
	b=TAFBXMrRJHnK/Yjew7KFVj1kd37T505IpbSb1SE7PAp9qy17mNhmpB6+TQ2bwPCOe6Ap
	 CCQzRaIbpMtvUvzNhqerRwKNqtvc5ajtKsOqo2ppqDDKzaukGJh5O1D5F9cIxGylSBkde
	 shz+Pd1wXdda1EGe+VfZMrbv4QUe56zNmIPB3K5JhIhKildbIVUoNlN5oP4g9ke2cfC96
	 68hiX+LaBVzYS76lZgYALeg18gGCutjRs6wXCZbq8RQAGTIgosNm8/+wOuSV+gvCyprZB
	 v2+u0gE2F+0jVSVZdV665s7mfWXu8GMmPCjgSRauY4AGJS6KdB7CrkI5hdO5UGivrAQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439015;
	bh=xJOeu0GVrgf57r4Xw0st2evRWSL8On+FoVFT3m37TkY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EB/5RnSK0C056NC6QiQEaq2xiXfwOcyeH0iug0ZPnaTmFjtlklyQvPxgXjNzwaNtY
	 uFsTyj+TjZvUqTGBUS5DDC5sutAzAt6CC30nVZ3jalTi2J9bV+Cg/xNRnKsSSB8rAg
	 KqyQT2OH7YsXZWqfAoY0R6eWjNZUEvtyXlt44ELFdV47wrj+tRCCMtr+hPNQ+xCpm1
	 HVlqfMcR3f+25Fg2uODKCLHamWVq8NENtT2XwiPpj1ejgfw3iUNfmYW3H5AeyN991u
	 ZjZrf5ZNE0HIXJZmvHjXk4MmNxrYYuk1mms4FFtgf30kT9xoDnU06P06Dn092DGhzC
	 cmYLMiMU+7rAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20E1160667;
	Sat, 31 Oct 2026 09:30:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 55B64156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:30:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B24B40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KqgDsqrUOcKi for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AAD42400FC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439008;
 b=RlCJ0F/0wOp7Tt4v/ThNJHeMGcue3j3G8ODQN/IqmEYyZNoKnEfKxStBvQq83qSgJBhC
 O8wbNoAiWu393pNXXUbLhWAFWtpX5A77AddjfdqYhKpneLOjKNZ+l0qZTBMAvAnLyggeN
 7tpRRP9wpGVJk6a5XlFtfz+sZxtOLcuwHCdCKf9avJlzyTxk77vvjNk/5q8+dmLXeMz8G
 nbwgP2R9RhCGGvixNHmk7/HuAn3wj08Q93XXbInfAHm35LpZHyB7FkdMPjowIG+fHutkP
 jHUBHoBI04ioykNVaZ9wIREsiXa9OacspnMRGf4rmxw2t9ajAAfrtVXvO4EwNKBxowg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439008;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=xJOeu0GVrgf57r4Xw0st2evRWSL8On+FoVFT3m37TkY=;
 b=le9neAgusKjHv0QhI5Ek+Duaoagblszp4ytoAp5srICkk5KnuxBAyvPx8D3hYuQQ1KBC
 YKxLQogxC4WSvQFOv7CxgvxVSlExJMM9fS/F3zpWOFwv9cLLm2WVCe5odJ8IvjunHtaDY
 OMPrlKn3MJ9yhezjufNsdZInAkFcq3tC8sHLjG+MPqvBMFlBvcHKpdRIsWB58Am1kBN1u
 xLfqfA7XRO1IjS63DWBLBWTbjYoU6zHdehlpPxQdVCfqisxRDP+xx350gbXTkKgPcnZ1N
 vCOli9QAlYTcSIXrN6dQ3sbOC6SgnOlmUJK/R+/aDbJtuT5BVzO0GzFeF2e9om3wo2A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cKNVOq0j; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=cKNVOq0j
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AAD42400FC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:30:08 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3adac5c10e3so978095a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439007; cv=none;
 d=google.com; s=arc-20260327;
 b=cOE8AHLMkENFtafHspApOhH4EwQpRAm4OFq4lRSLkM+9DswNeWwZXUJcoJENYpBwQq
 4QiOCL6t9HNcvbpzLWA6N5qFRgM0cahCQMYhKM6Jq1rYwbUbDJ0NTkq2cUQh96WmI7M6
 5FpYMDQzjy//UYku7mxW6Gpy3FerF9R2MvyTdGup2/IJBWy/IYvmbkHyFohVMVNSUOea
 1PT9gM7uIM6scsDLZY87LqsSYvl2aGb/uX1xqium9kPI47NN0qCNY6kvFhkfC5vnZKHK
 xyRMHI7/TcgVOQiEfX76RLXoviob4ibYg5uU+Kqgbhm44ftJYATzqDEVCEdXyYnbQSug
 hbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=xJOeu0GVrgf57r4Xw0st2evRWSL8On+FoVFT3m37TkY=;
 fh=eSGTpZ/+rqpDSLRAETcqVHJrTBA7Fx3Zl7gWkQXUacs=;
 b=fML7gKK/n4sBCvJtJBHxF4k2BlsHvZaRqdLib6LSdoByQtrbiGYSyHmbFEt9iYHnhL
 TwTaS3NLUwRWg0RaWFB2O9x8nxVDN+9HQTuRm7CxKlYdaPIrshAh7qeBrj2pr5NJf6Bp
 sPCzNtq45c92R6YQE4Y05FtkJ6Au+6OcaP9Ilg3UwfYq0koUIOwFCKz51O0CKYPMf9ns
 XRSTldfQM7tPSC7eDuh74UUyesGa3EzbCi5Zj6iYb/bE2xw/JSGrq8lE1wFnEd++cSTB
 Prygiww++tGL6rTCf6kB2NlFmEhpzcFG5XaKF3GAYhnAqLejnRfjsedno1n/0pWb3uOm
 66hw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439007; x=1794043807;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xJOeu0GVrgf57r4Xw0st2evRWSL8On+FoVFT3m37TkY=;
 b=cKNVOq0jkZhmPlYKpeusi1HHxIJOYWs3R7R1fSwiGKZWmzKQh/DnNBcxjS2nRmuXOx
 jS6NKEIxVx/a2co2eQVarWY+KmvUBaK0TXvTfZkLl8tDIKAwnoWT1uADt7PNzMq36aho
 m1q23fFCyWliVE7SPz7M9UWZsOkxALS83Vs1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439007; x=1794043807;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xJOeu0GVrgf57r4Xw0st2evRWSL8On+FoVFT3m37TkY=;
 b=QrVgszOjnIjDRhxTmNwXdMCgnb9cXYKo7HezQIPLAF90bt7Inr8Ecs7ql1T9bjodQ2
 Ix7qLkoHiHLuLxuXF2MASBWAbcFWUWVsYz8SveUbXaaukjnmnb44BxGBJpwD9BPMsR+x
 1SsXymtlAA6hkpSJnXXjTDV5An10gxPNElyU4tO20suTnh7AyQbZMW1lUio29vqi8ZNH
 HbHBpQRFy4pCOXPB3lqwxVwKToEsJVZZH1DAV9HB9YCq7muEHDP2ZhpFBI7Hj2h/UUho
 Liakoqwo4qpuQCWHeS8fBglxzQK0KaMkM9toO4neumLP5X2Lt/g/mBKtKs+NbIXyjetg
 3hlQ==
X-Gm-Message-State: AFq9FYJn4loVDlw9ZY7mZrhGPgDdkfHec9nD30bgMUD/S9Fu+7Yqq2Hf
 xL4XjFCm1z0NurwGSmvquE/HlUCGaOeJCFEDM1/E+Ozc8G1liqAfQ3jiR+5Gr9kwJxAgFl8NbBr
 0xt99vQKmA0nJl3ivHmdP4v5En+KMdhtJ3CWEWsuO
X-Gm-Gg: AYBFou0ExSRWoMeBp3P8OVtn1xEAnWgKyUwFmh3xtL9ZBUaXaqgxgYFYJ9CGYORhMLq
 8tN+YezQAoUa8xLu6VHV8Ro73AzXb/d1rorPowBDht+yScVNaj28v3BeZs5uMUsJcWviVh0pb86
 dwgSZLzEV3sW6AboLA6vDMs++v74xihkWdFqckoqng2zaxMTjAeC1CZVrQZHpeJNTTBgbnl0VyW
 gi04BRQ4E+PyYSlWewBXCIRtJPg0NE5UkieUBfMCPUO0GuN7xPw1cN0Cxk7/nWdYtkr+e7l+FFL
 7hLpAU3ZLn9OHmrOvtDI2UKUiMBpS6XDskp3py/3/yuB0vXHUjpn6TOUdtdu1ROaxv9M1z8KCKK
 nzbqW0wI09TrST7e9+uZcU5ccEtuhfIiMnZaHIJ1wYwrxpnl2WEhkHOee5QjkeR1rQs8dVch0
X-Received: by 2002:a17:90b:28c7:b0:3a0:a912:e759 with SMTP id
 98e67ed59e1d1-3ae897ee62amr3945487a91.25.1793439007521; Sat, 31 Oct 2026
 02:30:07 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:29:57 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:01:57 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-8-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
 <20261020-b4-reset-edl-rebootmode-v2-8-f690da515804@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:29:57 -0700
X-Gm-Features: AclHuK8G-uhCoh3sE9NUAsAcdi6m7eMPzeJExj-bA8c-IHVeAG9AD4L4QvSaHGQ
Message-ID: <CAFLszTh=R2PsEJnwo2XX2QkcFzLtntAA40UA+ENxhDO+WhGQVA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] doc: usage: reset: document device-tree-driven
 reset modes
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:46:19, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> doc: usage: reset: document device-tree-driven reset modes
>
> Document the "reset -m <mode>" and "reset -l" forms and explain that named
> reset modes are declared in the device tree (a "reboot-mode" subnode of the
> psci node) rather than hardcoded per SoC. Describe the 1-to-3 cell
> mode-<name> encoding and note that U-Boot's 32-bit PSCI cookie means a
> 3-cell mode with a non-zero cookie_hi is rejected rather than truncated.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
>  doc/usage/cmd/reset.rst | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
