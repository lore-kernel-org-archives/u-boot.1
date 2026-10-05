Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F82CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30D4C4065B;
	Mon,  5 Oct 2026 13:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2HARWqrDpf8C; Mon,  5 Oct 2026 13:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 07F6B4065D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791207075;
	b=Vu+CwqZTdhNadpB37NvEuvYVlN8T3kv/+l9qKGFunbVBLJsosdc/kICJSEO3lV58AQvf
	 v7L3R/cwB593pJzUGzpMoVEHi2kgZwlX1UBApMtFEmhVz3L1kgMK6/WHINaSxMKpsXF42
	 3VFlXXMnmhq1DwaaT6+m+OUg2KCJKwvJrXevCjfmMFVGUd4ShH2LJ8geFZC6tq9ILFVeU
	 VuYRAHJg1ZdUU+QLofk1w62Qba0UQWqHhTPobIQ5bQ7rB8SB0xUiCSxQTt/qHdk+ssEOr
	 45InOIDEJMcjo1bSv7WnwL+P4DtyqG1pK8L8oWxhahGqQHlxYXx2mLmQzXlkO5LW0/A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K9faViMIf/AeQsKcaiceot9/8qI8C3NNC86icqJnAbs=;
	b=EM7MXAWEAbM4ylqaq3B8bAlBCjrIY/1tuG3Vet7IKy7bRsbBWtK3qpIPV/PzgE/azlZN
	 JqoU/9NKR/vNsHUpxhqxsJJ2BQIDHk3IulXyRPnVu/5oFO5LYYnLDSlFfeEnEn5Lozrj8
	 4MhoU8BGz+h+SV+AU1VYH0X0nDve4KuQolLha+e4BGe5rCjuB6MpKw7Fl/xWtg/urR8FP
	 1SmDGv5eQsNylKik75GLpif9lZRASZTmjtoDc0NUXECOEuUg3yTQ7EfzvakdK5Ap+nKFN
	 opnjh/hjkiVZGgfYqv1yRvO6PsbGTKuuu/gTlOH7efTRIhNHBXQtWLdUTh4U1piAqrg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207075;
	bh=K9faViMIf/AeQsKcaiceot9/8qI8C3NNC86icqJnAbs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iKOlyXgqoz4fmczD6zpWmpf8PBxVyyQyIbIbzafhnNEATlnet6OMTbgI/PU26uBy2
	 sVPI+BXe6OWswNX2PMjkb/UwwlGYh0VzatfaCfAIN9DUnz0k3znvBPLZAIbeNhV+in
	 6azL5uvxe97uVXmcgFKam80N17gqxF7qQ/EdZskIgimrVqqURTYvOtThNYmrYvxoau
	 yviviICHrNq8Ze7zwwJ6Y/fFTmGv8Wgv25kJFYdl7QiUT4UN4jqvhPriu+8nkVzEH3
	 eGzXlYAf0DAJORdfW01neLW1aWUZHGATrEbD6Pd2tpKZvDJcuFVqGfOGnWYv1zVSIg
	 4FpckRx65sVZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07F6B4065D;
	Mon,  5 Oct 2026 13:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D52C338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4298460643
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CZgxTo12mW9l for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:15:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D0CE7605E0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791206145;
 b=X5Xoily1YsZzLkBtM4eVgKM1eJNRI6js9qvZ/3mwi0TL1gX3Z7eSHIeYk41coWS1Cm1n
 0W73jp+wQTfotgIOvHKsz8F33TuzfIjqBkBLmetpJYXXtx+FQWfmFndR+DSpfdrodE3sn
 6Zhv9Y9sEp/utJVXVCqyOYWU4foMj/q5Wk5YNJoB3SBy+BTGud/X79UvU6RilVJxu5+v5
 2gPWfPbtLs1p29I4Sf4ZZ9o1laxalJNND7X65XCa28v98e1Ol0sPDqWrdRA87PANJ/PGB
 SvKNRDblGIzUP/mohi5Uo/AFvrq10E4p8aMYqER4e4fvmM8WmaG+gvcA67CqNXPl5jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791206145;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=K9faViMIf/AeQsKcaiceot9/8qI8C3NNC86icqJnAbs=;
 b=a/f4lNEeTJH7DBV6K9QDXrXO6u1TERkCRyRmeT8cNzIk1xzxXLHNgjNoOZc+/EOGj949
 FDSrUkXGKSC/WnkDiUKaW5pis2tdObh4xFUeLc1Npah6WbgZpEmUMbA6wIA4Ehc/honm2
 vxFth6TRZZnqU98Zfh3Ru/uZH9CMtODzzRtuarTexErNtzmMr3ssBsVJ8II9AZGkgdmdP
 DPLuWzE8kvv9KqngXb/BonkxFBe80/Pyj3opuK0M/r0lj7hzmDhFr3TtRdItxzjf/RGKp
 7xwfH3d5I7VV4++gA8ih/h+DUHMhRDtRsNVybBs0Ogh/D+NboDWfbCmNlze0TS6ceNA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dPxndw05; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dPxndw05
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0CE7605E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:15:44 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-677dbe051d4so858870d50.0
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 06:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791206143; cv=none;
 d=google.com; s=arc-20260327;
 b=LDGEwE9NBWgWxsxv3ut+LDk7m5z2OfoAYx9KnfahftptvbpsAklwjnCUhNi3gZfo4E
 97Sd+JCEZXkYRAGqTu63g3L1zaq8izxlbM4+VZbRpi2cHKIlWapIYJGfEOAWgDfnPeR6
 ADNF1ldMWWqJO5XhwwcqZkA7srJvCx4ZP09sValY0Rf03GwYgfzFI8MRX/sPJm8cMmKd
 Lmrn441azwjktPFh0RJxSKeaV5nH8d66fxrlVynw8JyW5jl2snETrjggC0g3Q0XGmmXc
 C/WvZimJU/eBWPf+m5Cm5umVEMv6s5hizAoLA35Ik7cXaOL64G5G+N1zIj8264EI2wgb
 BeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K9faViMIf/AeQsKcaiceot9/8qI8C3NNC86icqJnAbs=;
 fh=dBPtYC1TZ/qisQKccqrPk+ZU1k6U81Ut+AAudAfs85g=;
 b=WVnKCVx+ygyIydzhLRGhyabmPU+KITlRySfz0ozZbQ7o/3eFsfZ+sari/NQsmVvbg4
 Ezan87U3dMUZ8qYdZEMCD17gkMQ8UMrlGyhXWLJnqtSMy0SzsrsyPS6MFAAtOI1Z3HO9
 Z7B2YH6ydElisnqX4IbV+/N16vdlVn7sUyk5DtaX1Q8Bbke/k9sq0Xwiqxvk4UcVCZjZ
 9/4Hgbc0r5kNJAWvNPBi3yb3c9PzASv1xxKxR9zpO3Xe5fQBRPSQdlIQXikl2KZQwwm0
 cKa2YDfqmu+iil5sa3SGKprVJXjllSOdDulOd3vNYpdTURgu7IOfTB9HNg+zZKTZcohJ
 Jg0A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791206143; x=1791810943;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K9faViMIf/AeQsKcaiceot9/8qI8C3NNC86icqJnAbs=;
 b=dPxndw05QTPWylSIKAEQet3qsj8BNFo2yN4jmhK1ArJZQyt5/s2aN1n1taapWB4hIc
 scRCgM5A6HivDUOf0hG46vWT1AwWdW/zh3wp24o1Btx6+ZzoIaGkY6SZNlb8k6YSktFJ
 2EqBtcfKl1yh0blrEHE4Y7leg+yjzdulf38yHfZbJUzq0tyAsiQAUCcS56ZdyDDFi94o
 rOS5eYtAQpk9l3ORywWvsbuKnL3Gp9VB39yD4lN7IQDODtb+N/pxVyjDTCg5Ez97Sx+e
 X3D1yT+r3RIsaoMH5Y+c8ftHviA/joCZ2UAmpI3mRC+r0x5jV2ddcqL8CeSSz1JC6MOk
 cqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791206143; x=1791810943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K9faViMIf/AeQsKcaiceot9/8qI8C3NNC86icqJnAbs=;
 b=VbBpuKLXdeg+wyC/AHH6uE3Jp/q/fcsQnS23SqzxaMq3uamtvFDjsidKPf3NMzbKzY
 w4Gd2K7jB9VgILuny98rvKLicTEtIxy+dSjMniZ3Svl13fbmrYX1VxzjI0/Wfsa3swHe
 nwAQtwDx4KggdFAP9MQ9Rnlve4HKNa+zsiCUNEzT3DAbr6013/sNSLB6sYsnA0mJ8y9t
 BQ7+nUX7bCS4prAlBHJtbv2ugLaAu6hN62Zn7c6SQT25rvsGfeTMMzEOgRvNHWLLydy9
 ckF5Z6e1wLddiVh5wqj37dLb3waKr9C1vhThEjJZUMiPw29v5t3KF3gxSaDPaQWKrFLY
 PJ3g==
X-Gm-Message-State: AFuF++lTf/Ac07W/oQLKAfRFU3auMZ/pP1Nz01DSfHAOjNNt9VzkQgf3
 uzO4UmCiMMOEip3cHAwf+H9pwgXJqZqRAD2csy5NDDYNBQSR3hHdPrFOFOORH0Q4IaajUo4A9jj
 SKK5uE81lD5Kal8LQQaNePJDGbPP63vfAtrrG61Xt6w==
X-Gm-Gg: AYBFou3b5X9qY0P5u+gvZGIJu6iEINcq4LK8H1pfmarW6y+PNIC9uuBT3Q62IfNE9wA
 WG46Td3LJhORUCQGdUsN3Z+bcDSR5kDWl87NNOEQQPMfiD103jP87BOSPsjM0b7ib0QvxIkPf+e
 W3eQw/V6kxk1gGecYfbWWrnHOnmuuI1R7WB6KhdmcX7J/sAriiyRmYAOTd4BP8E6xCZ6uW+Hgw0
 YmV3typ13UZIMpZCltpEUqhu7e9vQDytxTTj1WO3gn/OxqJkO+xbp1VdVocMMuvOwsjtEAMkpfL
 HnNReKqTdL/f6d3SdyUcxEmi33WbRqBRFZbxGmxUtQQUCvnP6t6HGBB5i+GAShulj6+2t87VjIu
 R7W+nHZhleJMYghrXi/nKEi8YuLVBWf3fBuIEBcLVe9A3M4nB8cZwfRkdoGI++/2HTjS+p6Xobb
 i73JgO84OYKgALz0NVkoWGo1gMCg8U+hUhl1+OBNAKLcsDmAxlG+x7+d+iJyqCSXsX30TazExL/
 MLKXUumNUsMJTGvg0YgbbC7ZSzAWQr2RQsANtBXiKsTIzOwX49VEBq3bThza1/tTgMQAKJyyAUC
 6BvKpTlq+7kVrSoN6upGi9vL8FZSCgdDcxN96dUCARuttP+SpRnm2cntgmyCKtrsGk2tH6JhzMH
 YPIhmUKeacfIyQaQDqnOFJIoUqRxemcobYaO1OyM/X7xrkVCbbbnyFw==
X-Received: by 2002:a05:690c:dc3:b0:854:819:64c9 with SMTP id
 00721157ae682-8ae94c98514mr23879447b3.30.1791206142846; Mon, 05 Oct 2026
 06:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
 <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
 <eca5e6ca-ef4a-4e20-9255-f7d20ebe0788@arm.com>
In-Reply-To: <eca5e6ca-ef4a-4e20-9255-f7d20ebe0788@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 5 Oct 2026 16:15:06 +0300
X-Gm-Features: AclHuK-hFrpU6Xk0SvjFi_z2NGVqE03ZVA2M79Quo2HjLEWsmulJwxU1gjgJxPk
Message-ID: <CAC_iWj+VHR_vGb8EYqR7tzLXihZLW586BjnjPsKswf9uDnngEw@mail.gmail.com>
Subject: Re: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 5 Oct 2026 at 16:06, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
>
>
> On 18/09/2026 19:20, Ilias Apalodimas wrote:
> > Hi Harsimran
> >
> >
> > [...]
> >
> >> +                                                       efi_uintn_t na=
me_size,
> >> +                                                       const efi_guid=
_t *vendor,
> >> +                                                       struct var_che=
ck_property *var_property)
> >> +{
> >> +    struct smm_variable_var_check_property *smm_property;
> >> +    efi_uintn_t payload_size;
> >> +    u8 *comm_buf =3D NULL;
> >> +    efi_status_t ret;
> >> +
> >> +    payload_size =3D sizeof(*smm_property) + name_size;
> >> +    if (payload_size > max_payload_size) {
> >> +            ret =3D EFI_INVALID_PARAMETER;
> >> +            return ret;
> >> +    }
> >> +    comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
> >> +                            SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_=
PROPERTY_SET,
> >> +                            &ret);
> >> +    if (!comm_buf)
> >> +            return ret;
> >> +
> >> +    efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(*vendor));
> >> +    smm_property->name_size =3D name_size;
> >> +    efi_memcpy_runtime(&smm_property->property, var_property,
> >> +                       sizeof(smm_property->property));
> >> +    efi_memcpy_runtime(smm_property->name, variable_name, name_size);
> >> +
> >> +    ret =3D mm_communicate(comm_buf, payload_size);
> >> +
> >> +    return ret;
> >> +}
> >> +
> >>  static efi_status_t get_property_int(const u16 *variable_name,
> >>                                   efi_uintn_t name_size,
> >>                                   const efi_guid_t *vendor,
> >> @@ -768,6 +800,49 @@ out:
> >>      return ret;
> >>  }
> >>
> >> +static efi_status_t __efi_runtime get_property_int_runtime(const u16 =
*variable_name,
> >> +                                                       efi_uintn_t na=
me_size,
> >> +                                                       const efi_guid=
_t *vendor,
> >> +                                                       struct var_che=
ck_property *var_property)
> >> +{
> >
> > The changes between this and the non-runtime version are limited to a f=
ew memcpy/memset calls.
> > It's pretty easy to only keep the runtime version and get rid of all th=
e duplication. Same
> > goes for the set_property_int()
> >
> >> +    struct smm_variable_var_check_property *smm_property;
> >> +    efi_uintn_t payload_size;
> >> +    u8 *comm_buf =3D NULL;
> >> +    efi_status_t ret;
> >> +
> >> +    efi_memset_runtime(var_property, 0, sizeof(*var_property));
> >> +    payload_size =3D sizeof(*smm_property) + name_size;
> >> +    if (payload_size > max_payload_size) {
> >> +            ret =3D EFI_INVALID_PARAMETER;
> >> +            return ret;
> >> +    }
> >> +    comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
> >> +                            SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_=
PROPERTY_GET,
> >> +                            &ret);
> >> +    if (!comm_buf)
> >> +            return ret;
> >> +
> >> +    efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_proper=
ty->guid));
> >> +    smm_property->name_size =3D name_size;
> >> +    efi_memcpy_runtime(smm_property->name, variable_name, name_size);
> >> +
> >> +    ret =3D mm_communicate(comm_buf, payload_size);
> >> +    /*
> >> +     * Currently only R/O property is supported in StMM.
> >> +     * Variables that are not set to R/O will not set the property in=
 StMM
> >> +     * and the call will return EFI_NOT_FOUND. We are setting the
> >> +     * properties to 0x0 so checking against that is enough for the
> >> +     * EFI_NOT_FOUND case.
> >> +     */
> >> +    if (ret =3D=3D EFI_NOT_FOUND)
> >> +            return EFI_SUCCESS;
> >> +    if (ret !=3D EFI_SUCCESS)
> >> +            return ret;
> >> +    efi_memcpy_runtime(var_property, &smm_property->property, sizeof(=
*var_property));
> >> +
> >> +    return EFI_SUCCESS;
> >> +}
> >> +
> >>  efi_status_t efi_get_variable_int(const u16 *variable_name,
> >>                                const efi_guid_t *vendor,
> >>                                u32 *attributes, efi_uintn_t *data_size=
,
> >> @@ -1001,7 +1076,7 @@ efi_status_t efi_set_variable_int(const u16 *var=
iable_name,
> >>              var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_RE=
AD_ONLY;
> >>              var_property.attributes =3D attributes;
> >>              var_property.minsize =3D 1;
> >> -            var_property.maxsize =3D var_acc->data_size;
> >> +            var_property.maxsize =3D data_size;
> >>              ret =3D set_property_int(variable_name, name_size, vendor=
, &var_property);
> >>      }
> >>
> >> @@ -1078,7 +1153,7 @@ efi_query_variable_info_runtime(u32 attributes, =
u64 *max_variable_storage_size,
> >>  }
> >>
> >>  /**
> >> - * efi_set_variable_runtime() - runtime implementation of SetVariable=
()
> >> + * efi_set_variable_int_runtime() - runtime implementation of SetVari=
able()
> >>   *
> >>   * @variable_name:  name of the variable
> >>   * @guid:           vendor GUID
> >> @@ -1088,11 +1163,69 @@ efi_query_variable_info_runtime(u32 attributes=
, u64 *max_variable_storage_size,
> >>   * Return:          status code
> >>   */
> >>  static efi_status_t __efi_runtime EFIAPI
> >> -efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
> >> -                     u32 attributes, efi_uintn_t data_size,
> >> -                     const void *data)
> >> +efi_set_variable_int_runtime(u16 *variable_name, const efi_guid_t *gu=
id,
> >> +                         u32 attributes, efi_uintn_t data_size,
> >> +                         const void *data)
> >>  {
> >> -    return EFI_UNSUPPORTED;
> >> +    efi_status_t ret, mm_communicate_ret =3D EFI_SUCCESS;
> >> +    struct var_check_property var_property;
> >> +    struct smm_variable_access *var_acc;
> >> +    efi_uintn_t payload_size;
> >> +    efi_uintn_t name_size;
> >> +    u8 *comm_buf =3D NULL;
> >> +    bool ro;
> >> +
> >> +    if (!variable_name || variable_name[0] =3D=3D 0 || !guid)
> >> +            return EFI_INVALID_PARAMETER;
> >> +
> >> +    if (data_size > 0 && !data)
> >> +            return EFI_INVALID_PARAMETER;
> >> +
> >> +    /* Check payload size */
> >> +    name_size =3D u16_strsize(variable_name);
> >> +    payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + dat=
a_size;
> >> +    if (payload_size > max_payload_size)
> >> +            return EFI_INVALID_PARAMETER;
> >> +
> >> +    ro =3D !!(attributes & EFI_VARIABLE_READ_ONLY);
> >> +    attributes &=3D EFI_VARIABLE_MASK;
> >> +
> >> +    ret =3D get_property_int_runtime(variable_name, name_size, guid,
> >> +                                   &var_property);
> >> +    if (ret !=3D EFI_SUCCESS)
> >> +            return ret;
> >> +
> >> +    if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY=
)
> >> +            return EFI_WRITE_PROTECTED;
> >> +
> >> +    comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
> >> +                            SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret)=
;
> >> +    if (!comm_buf)
> >> +            return ret;
> >> +
> >> +    /* Fill in contents */
> >> +    efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
> >> +    var_acc->data_size =3D data_size;
> >> +    var_acc->name_size =3D name_size;
> >> +    var_acc->attr =3D attributes;
> >> +    efi_memcpy_runtime(var_acc->name, variable_name, name_size);
> >> +    efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_si=
ze);
> >> +
> >> +    /* Communicate */
> >> +    ret =3D mm_communicate(comm_buf, payload_size);
> >> +    if (ret !=3D EFI_SUCCESS)
> >> +            mm_communicate_ret =3D ret;
> >> +
> >> +    if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_R=
EAD_ONLY)) {
> >> +            var_property.revision =3D VAR_CHECK_VARIABLE_PROPERTY_REV=
ISION;
> >> +            var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_RE=
AD_ONLY;
> >> +            var_property.attributes =3D attributes;
> >> +            var_property.minsize =3D 1;
> >> +            var_property.maxsize =3D data_size;
> >> +            ret =3D set_property_int_runtime(variable_name, name_size=
, guid, &var_property);
> >> +    }
> >> +
> >> +    return (mm_communicate_ret =3D=3D EFI_SUCCESS) ? ret : mm_communi=
cate_ret;
> >>  }
> >>
> >>  /**
> >> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
> >>      efi_runtime_services.get_variable =3D efi_get_variable_runtime;
> >>      efi_runtime_services.get_next_variable_name =3D
> >>                      efi_get_next_variable_name_runtime;
> >
> >
> > All the get_variable*() calls used to point to the function from efi_va=
r_common.c.
> > By changing this you are breaking the runtime case for OP-TEE since now=
 we will get
> > EFI_OUT_OF_RESOURCES.
> > There's no easy way to fix this at runtime. For OP-TEE the kernel might=
 replace this call
> > with an internal OP-TEE call if it's part of the firmware and announces=
 it can provide
> > EFI runtime services. However, the default uuse case, which we don't su=
pport SetVariable
> > at runtime only needs to keep working.
> >
> > I'll post a script next week so you can replicate and test this in QEMU=
 with OP-TEE etc.
> >
> > Cheers
> > /Ilias
> >
> Hi Ilias,
> Can you please share the script, so that I can replicate and test this
> in QEMU with OP-TEE?

https://github.com/apalos/efi_optee_variables

make run-fip should give you a QEMU command line. You just have to add
an OS image to test.

Cheers
/Ilias
>
> Thanks
> Harsimran Singh Tungal
> >> -    efi_runtime_services.set_variable =3D efi_set_variable_runtime;
> >> +    efi_runtime_services.set_variable =3D efi_set_variable_int_runtim=
e;
> >>      efi_update_table_header_crc32(&efi_runtime_services.hdr);
> >>
> >>      /* Record that ExitBootServices() has been called */
> >
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
