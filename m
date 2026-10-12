Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB0CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 07:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0093F80CCB;
	Mon, 12 Oct 2026 07:45:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxkRY6f58WHL; Mon, 12 Oct 2026 07:45:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 35F2280AED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791108;
	b=q9fiuTgCSNH6h/a1LLkX5DwL4xj9jDHdP7tavQ2ZBysFgJcJmEurQ2tTK4JSQ98VxEj5
	 osn024lyKYf+5gNff6U6U3ETNf26z3tWS+uM5OW/Iq2Vncb39JGfUYYSXJyP4ODMI5VyI
	 oK/06GGFGdEGor1+WyNWfQQoBSWdJuYeDynnmpoE6HE96ogiy36zRI6FDXAOVvKPm2FUb
	 Fv+aiO7Ckzl3ALSF7lV2rEpJz1fuKP4rlvQu7GYJ+rTfT0poDRNkoLjD2MTBibVYNU9hO
	 cUrlNvWOul3VgbK1lnMoT/btNph3wx3GZ/blGZ3y2Ts/G7TZr1Cp+0lsYOtKGh3kTCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791791108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XPNUyDkZC+Inzoeg8RN2Vt3y4j0/JIia9ng7Ji80FL4=;
	b=QLWmu/Ur8RfivoGtrPI23ciss5aLaW0MnhTOeD0fce1pL1zR1qlG5+PmUfgDbnwwSCYJ
	 9gRa1JxHfHa5Hba0usplVe9kCzLOTLwF1dUGbe8aGS0tpeErUYJx/qZxb1G4FUX8ZONDy
	 8jtiHZApQhffxDsHHicyIqLnS0K5xWSLxMQ2uPqvyrq+lOLW4mh9ycfe4pnHLPr7J8lhk
	 IkqgbgbKqLeJkYs7dQdu4i0wZ9YRGSfAau/HmG5vPuLmGVNzFQSyyQ+M9zyKDAMbUWUL9
	 1b4RMTXiWrBqSOpndrgk2WjmWBS8i7WZdPtbtAyl3C2HkDkJ0dGNOz5tXwYiUTSBqjA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791791108;
	bh=XPNUyDkZC+Inzoeg8RN2Vt3y4j0/JIia9ng7Ji80FL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0Gtlmaw81ivO+AqFcbANKHCJOPDN2HMtrShmFd/CGDgn1toUK/yX4ct5PIE1f3G0
	 G//KoH+6O6iHhWem2yW9Py2gIJvsq4GG1Car8NUAj/b2TLshA4jg7QPAVzMuTmcV2w
	 2yafpo9wiwYnKhAO5hYYhrTOmEZwovd6qsEHLQZrDQ23etUF9fyALXLzmKsfkyV98H
	 sa7wAjuVz8yeN5TB3Na//k8m/jXl99wDenmBlPOOFTzXXR0qCwCU2rhZFWcAhj+yPZ
	 DZm8/oIskAhxPPzGWHzpYnLfTjdaUOYlwMHOEDeITv6AwvZUoLjdTErccHmdsGacYL
	 j8wcraCWL8s0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35F2280AED;
	Mon, 12 Oct 2026 07:45:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CF3175
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ED1B405F8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWMcAhR6q1-P for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 07:45:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B484405F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791791106;
 b=V4CWrPybKJW8L7Wr+jF9oL06YJorr7D8XOQ4DEYaqSv2uEB2LocF3pRC7JCvrdPMb0Sm
 hIUcfhNsYp0i87VFKtmLwN6CxOTMElbqSKm/iONr2wKZ25qmuvgReJZ9mmiPlpypRsPbB
 9eCL/rEm6Kfgv/+wYen2lW0Mc4vZfa1RGKapvFeCUCLTVg4jBxy0MB6ODGrSwRB45uV7L
 sVsSs5n244ACcIuLe8Dq50pjTemrfK64K+CIwD5IFZJ8lu/CoER2gW7WBNM0i+Xcz9yMC
 eVnhoMZFv1CieFmZQHegN3pAqmdk4ER9vHBGKrr4brZi+1hY31m+Ev+XwcgDTRRsW7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791791106;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=XPNUyDkZC+Inzoeg8RN2Vt3y4j0/JIia9ng7Ji80FL4=;
 b=bPDbciwYDOKM3wmDJrbIlIWvgP1Iu2s9uVIGLHk7K5cANGXACk9ynqVFwLVnH+Ow1xPv
 d11Rd7dEYMo2SQ6pfB+1egVHQGN8sGD+8oU5UuKWKEd87ropK50TqyFBgsBaVqfhsegPU
 OFLsz4Wph1jdPupB7GXPUrCIdCmVVvGz0Db+lFGaLLk7c0YhkhzdUxRAtRJjby9e7F4Tl
 J8E94/ZSmS/XWlL0WwGi9dhBsWogKnLYTQlEOQZbwIEoxprPw+dalgzY/tZT29hyJgfCG
 ct5VpUqIkgN/cACoCr/0uTe0HZCQz0dzTTzTUu+8TF20nFGpJDGkLMwNGhERPO02mIg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=I6XCwVjV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=I6XCwVjV
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B484405F1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:45:05 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab02ba4dso1324154a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 00:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791791103; cv=none;
 d=google.com; s=arc-20260327;
 b=m/t20IlCXpK0ZTxwHZHWBhGqVxlq4v3MvAsaUAckDvWshYHAFeTZx1sXca2rZpV4I8
 7n0P28bRpadCMp6zSqV/+gM6z7mlHFI3w8vE1iNQl/9GtCH+RnfWaIaB7/pO8KDt9ZT8
 IxWy1FEX2d9bT2htlINqK2uz0Yw2uj77c1PCWH7iKtojkQ9M64pSVOCyeV2cbft4+QNU
 jFL6x75jRR273V/4k4jFHOHXHC8tUC8nZaptU139UJuGekNEadeE1g/8BnHlViCT7koT
 BhlGZrJtdWtPlsYYUYo+x0ZWzem1XYzw6CGxbTd8lYTYunX8f5kOrE1+LPnAlG77Ghj6
 lKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XPNUyDkZC+Inzoeg8RN2Vt3y4j0/JIia9ng7Ji80FL4=;
 fh=wbP4qAhiI8Lk/DEUjFBl49BCohTz8UK30uaiUZ9HbtQ=;
 b=WBjr8JBXGDM2iG47lGrW2X/Hj5d0g6WPo/xAlmWLySscnlBO+Jg0gj7Jhx7A4RLzEW
 f4GaeyXCOOi9FW2lLJEohgCbn5We66uYhgWmqtBb5QnsBNCbcU5e4V/PRKYhIf4/G7RM
 TlDvDVDtJtrfJepD/kKrTSofOSul82tZ5husRzrfkHN9TF2o9Ksg9tRDaR0/T9VdD3AW
 5Z1UogLlOLa7b4Cwhb7IXWOO9CjFxD5coM69VrGwDjttcgrC7cUwbK01I/tUAAfRpHz/
 xwPDF4jt2g0exhkBZDtH3jf51+a/Gn7pou77DpwFIwaXJp9tU1yVAO+JxlIrdIjoO7Bc
 i/yw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791791103; x=1792395903;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XPNUyDkZC+Inzoeg8RN2Vt3y4j0/JIia9ng7Ji80FL4=;
 b=I6XCwVjVH+OFeZ//zV+FAMNZRjlOEqZ0ccQX/ACEFYAlALb2Q7ktYiUoz0kbPVe32u
 PhaLvvs90p1IjbaXiaf8LkA9tM0ujw5OOLaMKnZHEEP5BYXEjxfXp3fwtIDOB04epgk4
 ysxzjRfZxcoqT4TSMDDt5f9gi9G02en6+v5OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791791103; x=1792395903;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XPNUyDkZC+Inzoeg8RN2Vt3y4j0/JIia9ng7Ji80FL4=;
 b=M04qyZMyQLUBLcqh920WOEpZBb/FINJNwv1pd7aFehpl8mGw3uVlY12gb7ajTE9I8m
 U3gWAdnq2N6k/MMyfm+F8VmDPrS238GNs2QR/TM7/kxwfRtnmREt8XvU5MZ8PYeHB/rd
 hn1HZJivZ9VGG8EW4Z0IqvnltDg7b40mbms7+AHnH+eARSyM6ZnPrx7gnV5zCd3ZKqih
 wznCkwWV16bBBNNBgSucLXhtPiPK0a1/PiI9FP2yP4Yj0VNmQhh6eOXmIU4QN6BFfCIm
 8abafiDnFoyydUWwgcJg1qdzZZekYacpq9zcEJO0ssKjXQSwavkNH8QCuowoau3XNhRv
 QjIw==
X-Gm-Message-State: AFq9FYJ/cqu1q9zepX8JhcnCAZ81wVRecSsdLK5sTVnCS2lIx7pnZqyH
 JCF6Ztmj25hAVpp2ei9e5ftmVq0nw5UgR+l/GFCu1yzinCyby6Y4qYprALvX1lVaqKWxelvL/Hj
 Cif1JHHRRJlevfOuFWFl+SQv0Vz/Fi/abHx7mVCKT
X-Gm-Gg: AYBFou0Vc9aVD/Z2K0Ydba3MsuwGmaXHRMspwlhbz3mNWXIXhIbxXEqCVpmFVBgrqNo
 UgCh+kVqiI/W0X3mbF3tLJMr1jXg4GDmpHP4m5df2z4BnPuDw+ccTDlDM9tAri+qt/nyJRA29aJ
 pUQziZUaDsa4EfJIQKy9hMdcHR/QgBv+iKZ2aPkscQdByXpOSUP1ku4z1ErBgNzLkafOYpYtvAv
 IG3KoOeYm8/3omgAE9rVJIXUetGUnE9TNQ0ifdM2RWSGVS23qyHoRYLzCM9AUkZND7EWwM7Fnml
 ZnDJ8rnTg7LTACb6x8FehBd1urtHiPz8UDpx+5FjZsDY4BgFbYcnIcVJ
X-Received: by 2002:a05:6402:52d4:b0:6b1:ba86:5f48 with SMTP id
 4fb4d7f45d1cf-6b1ba8663fdmr1852079a12.36.1791791103311; Mon, 12 Oct 2026
 00:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261006155217.187050-1-michael.haener@siemens.com>
 <20261008215518.209510-1-michael.haener@siemens.com>
 <20261008215518.209510-3-michael.haener@siemens.com>
In-Reply-To: <20261008215518.209510-3-michael.haener@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 08:44:51 +0100
X-Gm-Features: AclHuK-4p_0PQcvItrd_o1xxocgT8cqa8B-KKd1p4qPz27Whn7aprtewph4dnRM
Message-ID: <CAFLszTjJ2=TgoTBL5o8jpBcpoZWxp7DdBnaTsHPQhNdXdsR4Tw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] tpm: Add tests for CONFIG_TPM_AUTOSTART
To: michael.haener@siemens.com
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-08T21:55:17, Michael Haener <michael.haener@siemens.com> wrote:
> tpm: Add tests for CONFIG_TPM_AUTOSTART
>
> Enable CONFIG_TPM_AUTOSTART on sandbox and add two tests which call
> tpm_autostart_init(): one checks that the first TPM is started, the
> other that a missing TPM is skipped silently. Both check that nothing
> is printed.
>
> Add the new event spy to test_event_dump.py, which lists every spy in
> the sandbox image.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
>
> configs/sandbox_defconfig        |  1 +
>  test/dm/tpm.c                    | 47 ++++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_event_dump.py |  1 +
>  3 files changed, 49 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
