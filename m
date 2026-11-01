Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B136606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O7brgu3M;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=XdXo913z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D173B405ED;
	Sun,  1 Nov 2026 14:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fzb38DuJp2d2; Sun,  1 Nov 2026 14:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 084FE405F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793545161;
	b=XuG+LLmGjSO6mufX1O4ItoXNDlF9H4bDDlws3qPDyCEKqLmF4eLNmnTW5j1I5nFcobLW
	 hkQygJvDOKyvtCUQ+KnvPNQqt+Gk6XNTYUTHPWt0wmRPOz8dLPZe4CyOn+lH6dj79n2sJ
	 a21lm6ngl23OlU9Qoe+g5H9g4dnEwNKhW4+zAWyh5DgFTWW5jYAqGwWCiedTiBgOwZg3z
	 kVJCEaxrMwdW/GHarnT9lD3T64MuiVH4WL2pmYxQSXgroB7GoFh9DoQ325d1s/Ik6ePMs
	 DAT/y46P3G0cr3Ul+F/6g/z39I45g28OtsUnz1nbPdujCMIouO8TrVuFwFtVMBIiy0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793545161;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=A5BPcV+NqF4WS0t/gGlhe2dMkzD7zPSfO+cGoKnTJfY=;
	b=epYwTJD1mavzHlBfEJxCNeO0Xyv6dNmMsIN86Ekm8fgnboEgXv7y3sd4gOdgKAWT9ma8
	 mwaSmkhrhY3ig42Ap8Pkc/7eQmi2jx0edL1EZdDnJfmrQkDolaKMtBfrIbNDHrBfdP+TR
	 Uiqt3NzSU+fXZ003cBCyl8wt1U6DuTRVJeqW82KuHrIIby51qz67T6660BFBQ3DObhX/e
	 s4u60LPIrX/XaPstg8DuK9atrK2TepF7Csf8n7ovE5JKXa5YnUFH+WnYoVL8ZyM3yDD63
	 FUamWWFkpKGOsSk+vZToB3tYZCq53mnZEQa6b4tMkLFXaUdHJi24leaMwpHWXLJrD8g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793545161;
	bh=A5BPcV+NqF4WS0t/gGlhe2dMkzD7zPSfO+cGoKnTJfY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O7brgu3MS3x/YRhVb5ggTUJrqNF3oIWe0dpOK6Tw4pNM83ZMA0NEygO25n3cccZr/
	 bH3Eo6nJaoI0ByePk9mA/Nz8C+OLjlah9dxqYyloapexrH9pfEUowCsUJYIPToopow
	 TLap5bX7HqBzFkQn4MpX+Z+q+Thz9ZB4fuVlghRYboWFD5iuknwkZrqTevX0S20GRi
	 WzFJ3FJhxoVjXEyKqkvLOkNbb4Lzh9/Fu7OITaebDXGkauB/27BYX0SstT8eVRpO8W
	 EXNOGj6b5Cl4dzArLBpVFVLblVWFO/QIS0I8JMhG0DqxFgh5miuEqjUvNoDB4tEIxi
	 4oG8mEcSi1+Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 084FE405F5;
	Sun,  1 Nov 2026 14:59:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C96854B7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA7D580D2B
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jd-8LqOwCzEc for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 14:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AAE3580D13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793545159;
 b=YGrfeVMvEUlMhe7ragxCsdIFn+t48Q2mErEAbBVjQc9d4T7knagmOCFhMRblKRJ1lvLc
 5xRxy73V4ZvUwXI74KfOfAztFjl56Ma/n+N6Te0KYE0hTibVvI7GSCGHlXn22zOXJLujc
 kQVLUdA70S35NtWzm22imC3kGM+2gECgduEzA0ldnFI6gLUyHuKkStIQspBPhZNOg9BRk
 m+Nmd6vZNkqDY3FJ4Px7xc3WpIEW5Bi8TCq9Y52VxKjw2UlCb5BnUKe/DpvarIVpD8wYm
 IDpJ8eDe1v9CKIdM/pnLB85txi/d+ecZvCam3CGwxkCBKPMetNUl0HE4CyvdcXW7Qzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793545159;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=A5BPcV+NqF4WS0t/gGlhe2dMkzD7zPSfO+cGoKnTJfY=;
 b=Q78dZJfYp+Y1fuu0yKFfYoupAKQq/4/SDAWwYgUH5Ha0E12hOGZG4LwX/otUJrRHRsA3
 cI/xn1RxFRkMltQfzKs65Gr0Lhwq4dF7yqUMYnN/oIcVhvd3wZMgAu7gpC08MaRQfJ5H5
 VRSnouXZ+gxilDqCVfGkBFe4kX2gCHL0yjawqpWFhUhBilRcEAq5oDeh9Tzyt4UbQboMk
 tqNHBGkLecUkIis1ah+R6hbRh/pdnTmr6XNOaRwFPYFtyDIeYN1arrLOBAoE5T6dsu5/l
 ASpUyyo6TGa+adWoCJJaDWyA+VDmy6VA+Fyae4kMsJ5pGpFcjKYYD7guFPOUugKp0kw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XdXo913z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XdXo913z
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AAE3580D13
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 14:59:18 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso4434877a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 06:59:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793545156; cv=none;
 d=google.com; s=arc-20260327;
 b=DsGUHeRPg9IQuPPNlnAH5K/VC2gWhpgOmuJejVZjutTXwSPo5bjEedoFb/18r9IVmC
 iD+rTmDYJMR1j9WAafLpfZBmZ7wnGpDqYz8it5wHTXbyFEME7h24kwmO+VuoeUCeNCaS
 7dXd2HSubYYieykLxVUxbZsQVUmnsWDXAztbOwq9W8ARbPoGi47sWOBSu/KBZNHVx4um
 SGYRJ4Wx9WsrHWCScJTUGEWeWmuPOE1qpqb5itbm3QspdK3cdLE4GdAEMJ/jQShX+6qK
 FyEC84QmChCH1Tg6eCw4T6OUPZsSNcYKrSpDbydivez5w/c8yAYqRrppyx6BmVy25oH8
 9YWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=A5BPcV+NqF4WS0t/gGlhe2dMkzD7zPSfO+cGoKnTJfY=;
 fh=LTBw0z40mhiQHIajwjRrD1IzP5489zydJvVqnU0J8Zs=;
 b=U+gWZSpjaDzB2pNMtw14q/oFJ93tQe6W7rh7rDfoAYlSrcAWStfcyWTYfjT8LlU/05
 lbxBNb52P4Hxy5iucUyny5vpWPgehcVPmc5+0ov1fk/cgwvtIpKstXKyQotIkf1gsZz0
 TVjCB64tyqBmN6vTgnhhlb0s/E7/+O+gSkraBMV09FJuqk4E612B0PJmtdznHqJRH1Sr
 d3Jl14EqJTAnNNiCRFCTCy7oMkn/63KUZJcYN+nyIbXRTh9pxGmuyajhMT/utagOVJR2
 pKlZq34JjVRL6lAtOJ9u+95OjeTvBIeR4b8ThL4YTKZfNg8DchUV++kL1rALSl1zwSrf
 yxEQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793545156; x=1794149956;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A5BPcV+NqF4WS0t/gGlhe2dMkzD7zPSfO+cGoKnTJfY=;
 b=XdXo913zjThPC5wp/nAO2LeQa4kdPTNkTVny0xedxdbcLUKs9tKjz5+T6Zc3Kb6SLM
 1IFiCvTZBG9VpXcU0bcAw1gh+FHRWREOnx5DG5iY2PNUZYzwPW3Ylh8PCyxyDC4zzlzN
 MXigTIiVfoBhHrh/6vnT+TPBDW3shwLbq/jLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793545156; x=1794149956;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A5BPcV+NqF4WS0t/gGlhe2dMkzD7zPSfO+cGoKnTJfY=;
 b=siHrf3eYjRwKnJdfhYv1j4CUZ93my7RSKLArjph8aahOuYYeZyg41Hdfu/TTrG7ORh
 eyppgsyFig1tPY4FAtQwEW1QYJFjRa+iitInZNV82IG5JJTpPp+514i6sIQTHR6XmMbH
 4eXPKWUrO691lYoJRnNa44bg3gRJ3iasyPOPpgje+x6y/3IiSs/jrpauiVqXXvjLDGSz
 lfqe48Qa+u05b5sMU7Ci2lvI+4l/WG1yFDqUyagn49VYihuscdvW7Lso1iiFE4lD6ii7
 Q6anQbDCw6rhZB1//MqqYLRJQ4z+hoR+0oNFev+DSpPntTJ4Q/4W2vM813elplEhyXQ0
 2dKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0fDrCgTc7WjiTnuYNEgYcHVCpCC0jE+I01B/o1wGOAR4ajeIIHeN79c3zpF9o4OY4VWNJ5Nw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8tZzvTD5VXH49u0sxsmnzE9rTJsAW3NK1lTGd+k1wW+n9NFXeb
 I7pt33kG9Kj8XMqp0Kn/xAAyhPYWyTVNSC6SDZz9AUfQmJ3h1X50Za+SmdXGaZy/kz4RzzanBZn
 VHYNa6Na6yhCiVYv8VEaoCfqESJ0r+g9hbBDHC+YD
X-Gm-Gg: AYBFou3vK2cqUIi6fhC1lM5to6aZnkJBf+jGAbRUuWNZeiwQpDWPUfteN2vstepXA3u
 CBv9Q2ryiVCTzaLo5+ZOkK2qCyyXje0nWm55A5SEr18+6TQV3WxRbs1EgPdH2RFKWk0DXkJPZqo
 qWEFOGUzHitODCk1r9YyLLTh1nZBjv+buHUrMX/DVTzPGqGwVt6uijLM1NVgiOgt2nqfMbO2blv
 jHhZ0m734wfFY3gmbK9RHz9HtX3WhVcjfyQjRJbesAuRHqCegr8QvyNTv697g1+qZkaT/TAvUPb
 +9e6x+u8sloo/9W9IbxjI1Z32LHPHxgBdoOP2lQjIg7gocgMTYaFWkLoHB4lpI82x3Dk9NXIAZ6
 6ykYZvwHDoNr4Sp7hMg6Hs9rI40EjqtCQeA6Hy/MFvX9aIvBhAZuf6TtgD5iE5ELyCnkpPbcP0Z
 xjsOCxVH0ahO5kSbpq
X-Received: by 2002:aa7:cf1a:0:b0:6aa:f2cb:754c with SMTP id
 4fb4d7f45d1cf-6b4d428ea70mr4299092a12.10.1793545156231; Sun, 01 Nov 2026
 06:59:16 -0800 (PST)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 06:59:14 -0800
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 1 Nov 2026 01:35:46 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d416499f-dd42-4162-91f9-1752f090142d@gmail.com>
References: <1ea4ecf3-70d8-4469-be94-1943ab8e3337@gmail.com>
 <d416499f-dd42-4162-91f9-1752f090142d@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 06:59:14 -0800
X-Gm-Features: AclHuK8R6eTF-4cRsjQgD2bE86OBXfO9nv4f0wwSI1vkdyw4jTGCCgHCod2JXhc
Message-ID: <CAFLszTg9-NCfmc7qGgzmFTeVk+bja=adrj8P=bZsUQ7D4GZ+=g@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] efi_loader: Measure the GPT the partition driver
 uses
To: anabobillo3@gmail.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>,
 Javier Martinez Canillas <javierm@redhat.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-01T07:01:22+11:00, Ana Bobillo <anabobillo3@gmail.com> wrote:
> efi_loader: Measure the GPT the partition driver uses
>
> tcg2_measure_gpt_data() reads the primary GPT and measures it into
> PCR 5 without checking it, while the partition driver uses the backup
> GPT when the primary header or entries are not valid. So PCR 5 may hold
> a GPT the partitions were not found in: a change to an unused primary
> entry, which is not measured, leaves PCR 5 as it was while the
> partitions come from the backup GPT. Nor are the sizes in the header
> checked, so an entry array size that wraps in 32 bits makes the walks
> read past the end of the entry buffer.
>
> Measure the GPT the partitions are found in, read by the partition
> driver's own code through a new part_get_gpt(), which checks the sizes
> too. When the primary GPT is not valid, measure the backup header as
> the primary header that 'gpt repair' writes from it, so that PCR 5 is
> as for the repaired disk; a primary header marked to be ignored
> (ChromeOS) is never repaired, so measure the backup header as it is
> then. If no valid GPT is read, measure no GPT event but return success,
> so that the separators are still measured.
>
> EDK2 measures the GPT its partition driver uses too, since 7c12d4359abd
> ("SecurityPkg/DxeTpm2MeasureBootLib: Use GptLib parser"), with the
> primary header that driver restores from the backup.
>
> Add a sandbox test that checks PCR 5 for a valid GPT, an entry array
> size that wraps, a backup GPT that differs from a broken primary one
> and an ignored primary header, and check part_get_gpt() in
> lib_test_gpt_sizes.
>
> Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
>
>  disk/part_efi.c                |  27 +++++
>  include/part.h                 |  27 +++++
>  lib/efi_loader/efi_tcg2.c      |  52 +++++----
>  test/lib/part_efi.c            |  61 +++++++++-
>  test/py/tests/test_efi_tcg2.py | 246 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 385 insertions(+), 28 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
