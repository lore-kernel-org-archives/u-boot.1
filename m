Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426FB606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yb88n+d0;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAeiBkVd
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D47E40AAE;
	Fri, 30 Oct 2026 07:54:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rg1ivyjXFDo6; Fri, 30 Oct 2026 07:54:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F5E440ABC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793346891;
	b=Zq64UYbTVrkx/vW/I7nUUihA9Fi8r2aGz4qaSBx1cIk2NYtS9Jh1EHOEo04UBeaB19H0
	 S27GPAGSIVPXk5iZ+W9ahfQtvRzBLTnqJrRXD6zjH3OmUn48GeJsQNabiyZD3e3Gjnmw7
	 nRnB1zjKz2DhYT948AUeUFU/q4BQvZVRc+TC5zQ/swgLIIV0OfmHE3Ezqtl2AS13frCQ8
	 3k2mP4/ogU9nZkiKH6yWwQBL9Oi1exod8bElt2hmDX5dJooZdHKKNuOF4LfKGare5lzE3
	 wXB4arTzyUBNTQYHEBnhWQQTdFrSS36Ss6C6ALCVMOwxOulbHBK0vPuOufHZEIHkLuQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793346891;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yHQGp6ipfnFL3N6jQ9skfpj0e6iwUW8OEIdU3gHUvmk=;
	b=A7bsqV9phJsroy+C/AcDmXyHOC57w0CkgdMD+mtb2w5mG+IMSEE1Nq1S7KTYXRb5npSU
	 yTm9+vVxNEsFiESS9LPOITm9g55qDcHMcTF4A/0ZnFvYH3elohUeLIhA6blKX1pyaGH+8
	 HDAew2Mc/9VkxXxwEPvBCMKWd7IMSMgnDI5YCIzYkmReDzUmLKBrLsInsrx9z3jeUY8i/
	 /q2UvbZmrclFMILAP83pXXQdId6MLourVFTtPVxJZ/rbMt7Rdv4YAVmIBthYOA8NXqsES
	 IQpFSGnMCxlIyNihi4XBhm0mBBm+BQiaOvaXxuI7o4L94w5YQgdqMk0eInP3h4GmhTQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793346891;
	bh=yHQGp6ipfnFL3N6jQ9skfpj0e6iwUW8OEIdU3gHUvmk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yb88n+d0ClY26NU/4LF/yz/ULpaLDrociQ6GTtbSa9y2rgZGRCX8Z7KmdIZbT5hfs
	 arjK8vHdAdeNYYnJa90OVYkXJSxbfJsGq1Oh+PJBFiRdU7LgfxoygPSKmAfiJUmQEu
	 MMlZuK0cYUWgAF5ouaRGQTqzi9VvW9eX2gMYDoiktPUEesbDNVu3jfV8nHtaPelDCb
	 8Dhkg/1YZdPIU6ZwFGkVQna1h1O34FZjNWtl7D900EsMK4rcNdOP76SczfOo3N1n2O
	 hRfnsktYHjbsTr1AmpqwOc6u45CiORlAjylcQt0it4xpbt/od/WOBPXt8EK2RlrgHX
	 uuS0hf0aZGJHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F5E440ABC;
	Fri, 30 Oct 2026 07:54:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3E7E23AF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BDA3606B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-uyQYI6ryQ1 for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 07:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7419C60690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793346888;
 b=If4fLIvcBDdXtHjHokGfd9+PKtgDt/UVD4HCTOKZlVdor37Tuvok0jk5qPZ7WmXujimM
 1LnNyd8sJqnd7HUOsC3par2JpeRJ+2blgBC2r2dyL/mH3rhOWZe+rIxE9EJpVUhHYYYrM
 0s0bYQDNpAK9LInyqhHFCp58metFt/+nkKSpOiaT64DFZ6/jdcRLxypVSqJTMqZSn4hjv
 qz5ffXoUPrj4bf2bpMRuVDVhYQNtFc2iphlXVE21N/WGQ3WlhtC8OX3nEbo0FH2EI4Oqc
 5OQLEqP2Fj6L1orA8KdU3Rb1/CbDerRv2PwhjVRJ8sicAmO22x1Pt37YEn4TKZkNA6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793346888;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=yHQGp6ipfnFL3N6jQ9skfpj0e6iwUW8OEIdU3gHUvmk=;
 b=mEcqptjlHA2jnVcViQWUpUlJrQ2de8Q6pBw1za+5kiuSVF28wLJGSzQL8GqRBRJapofo
 X0rBedpAJf6qS6QysQA83Tt4na+1Ro+Iokw77crjZfHMkIeVKIzY/ynAMhCRrhQ78pZv/
 8lRkIXIeqXTIWZfx3E3odWSKog+suYPXoQ+4Kxf1PD+v7gF3oudCTSXb0YhFHSrWE+J3Z
 5w//JKH6kNEBSi7Rve3nWBh/I+rT7d28MFnsFAOoZ/vdmFh53zP/LaxXsv2zT4zvq9Fq3
 T8cSl06pXI+vs6AagI0zOLQd3O68Sp9OuRLGgtJMWfaXIDjNqNvMAR3/JGAlKTLVVHA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=QAeiBkVd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QAeiBkVd
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7419C60690
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 07:54:47 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-84e513874f8so349129a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 00:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793346887; cv=none;
 d=google.com; s=arc-20260327;
 b=dPOej4oHL6ZpwU/FFUDEZiQjGqnvEqAHZ6gQE+TXDaEJeTKpw0KziMQy7eImSkSL2i
 yErMAyrCAth1bwIaE1fY2AMrQD9NBOzvlVw/OKvmve2DY+AHpRgp77PBXKMQX5c3crk0
 YfDlSRjPkLiyyIx9aX3hYexthQbXWmsqS1P6OlpwSvC9oZNeok/WLESukZFDlsKYaJc9
 mvWYOWNvObWh+EDC18AfWRzMxvE8FnByNRebKfShOm/88uK/SPncN8JkDmFot7YW5dLA
 hNJjCMZIof8snZHj0CVk6xYfOhxTKLQvDLk7jpWMRgtSAeQymcX6R2AtR5ysDqkcJu9c
 aVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=yHQGp6ipfnFL3N6jQ9skfpj0e6iwUW8OEIdU3gHUvmk=;
 fh=0/NjL8o7GK1Gqvi8LaMHvqkCbtWdfb9jHUbMCcbnqS8=;
 b=m7shybsYw6dnVOorfV+lKvoIDa3DvZeS7ZfM4C81dpuSuuurGaCo+brATiXYui6pVf
 TrOstgavlGJ2Bc178imv8fDTTWiDOf90Mrvrlvk8G0FEmmjrWMA1bhcbVzbGf2V80a/c
 OkF8SJcMbCzOU45dBVdNFvvEdpNbmZfIezMOq44j0IoAeXF3Yoje4gly3w4u/JeAAMZT
 p+0OQ7zqVJOEdLhS3P0dFSxhAFdr8w1zZ4M1V3Y1BFRMJ135hVlPuLU9lbSGfx6vRb38
 PskCQiaUk3d+rEZ/xOg6UedH7qYuhtmOpvE4eBXs5+IVmYmuf8FuFiDWVSfFzcTnxH5R
 kPzA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793346887; x=1793951687;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yHQGp6ipfnFL3N6jQ9skfpj0e6iwUW8OEIdU3gHUvmk=;
 b=QAeiBkVd8tkDtrp4caNh2xfe3HGoFQazRTlOIW+IFjDzuuJf422/jWlFFD3jNFwr65
 i0wfWsS+bGJmB4BqJi0KDxFPM7U6GNXcPLsBaC9ozZzJkMESvaue5ym5W6sVoAU8Hr43
 5kfmXxg7zjpU/XSnum53DmKolz63jChz8dhz+ZIED6PfuhFNphTwYWQExNOSBhQJEv61
 Ci4hhKD9m/rV6HOJudR5a0UxiOtCkGzEoDNsZ6zMA/TjODvxvIVTVLkwGjmkSBd6EnCm
 lu/86v+OwcQDxGwK20e4DpPvnjz0l4VXIvb8is5NPvy04Sekv9LGZx9VgZZsnSr1bwO6
 dhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793346887; x=1793951687;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yHQGp6ipfnFL3N6jQ9skfpj0e6iwUW8OEIdU3gHUvmk=;
 b=i7i5BF73cYDp9Lbht0avdsAy639wcgurTit0NArC5A+d/yQ0mCnqLv7l6lF3kO80nX
 77crPSTPQgcI/5OXrrVMZXmR5aAx378BRE+vORQH0kowPaFXc1GVLOu7JKAz9LhAm2VQ
 61BQpVeCgwQ7IF3tfSLazvE9+yPQToSbWoMay29rR1KFHSauX/6V/ATDdbb+2zNu+ONs
 KBmL262yGvrqX85HKFhnebRDvOm5j9KFKEtz0Btp7k05mj40I87EfEGvknWX2OzTa6mW
 +jn8ZuC3TLbGnpYE5UtVjt5sJ2tQQyiiQyyRNlrgbtULThmT58OlMwT3fEvEGHxpPzWd
 eeiQ==
X-Gm-Message-State: AFq9FYJsJE1oivlckpyq7ioRAcTsy8eb0DFXrnLaGnK2rihARcHSspNQ
 DeN0R0p1Bcn5Va1yJAgl4gj+RijqM/AaBHosFzE3QBCFRZhCR0ehlyo4T1YUS/SKUjcFp+6hXD9
 J+knCzLNzk0E+UP2jnFTt0bgmXd5dnrE=
X-Gm-Gg: AYBFou2ea/O6wlIef1xOrfGiP75UfHChjG2a1dmvEFaBqnIX632yTDNpOV6pw2umHLX
 mzeLWp6nRPqrYQNOrUqZSVG/1KV+/sPSSChlSwMOk7Lc02AeqGYkHtMSM/5anLJntomPCUxjioF
 YsFBWZaHmx3UKyfRMjeFKUiu7FMWV8aFL2Px+18gaDhXnGuRge4WnPO46Rc1VXTfKUiW5F0E6TW
 2qklBJpSdfORaLydAvsnUHAefMZqrOdYsedeI7gvCQyGvkJ55JIi5Fu5qH49vZsZ2NicDhyRTgC
 PGxFFH0UG8OTGLQL6EVZwxk0lcpWv/iiGIth0pK6UYcrZnlr+88+hMZF3ekSLSGzRTv4FQtYE8v
 Cg/k6q/+UJSYJQftOk7Q8Wzd3/5gcUXOxVFQ2zw==
X-Received: by 2002:a05:6808:c413:b0:4f3:e98f:fa0b with SMTP id
 5614622812f47-5640d9718e6mr1086372b6e.5.1793346886682; Fri, 30 Oct 2026
 00:54:46 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 00:54:46 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 30 Oct 2026 00:54:46 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAC_iWjLuP0zLWHKCnaCzGL-iG1bR4gR7AqumaPm_yQ9MqgBfrg@mail.gmail.com>
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <be672b54-42c4-48fa-a7ad-994a7ab47ea7@gmail.com>
 <CAC_iWjLuP0zLWHKCnaCzGL-iG1bR4gR7AqumaPm_yQ9MqgBfrg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 30 Oct 2026 00:54:46 -0700
X-Gm-Features: AclHuK9N8II7QpH5fJ55S1B8iduUY7PbQcCxkEeZSzShcguI04trBHCPmFaZQl8
Message-ID: <CAJnxHsjrmr_6T1vXxOfX0y2N6_Te1w5dKwEHnkUfyW-7yJ+i6w@mail.gmail.com>
Subject: Re: [PATCH 08/10] efi_loader: do not load an image that cannot be
 measured
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Fri, 30 Oct 2026 at 09:22, Ilias Apalodimas wrote:
> This is a policy decision. The logic behind this is that the OS is
> responsible for catching wrong measurements, not the firmware.
> E.g sealed keys etc would fail. If someone cares so much about
> security, wouldn't EFI secure boot be enough to verify the image? IOW
> do have use cases where people rely *only* on a TPM for security?

The OS can catch a wrong measurement, but not a missing one. An image
that U-Boot starts without measuring it runs with boot services, so it
can load and start the expected boot loader itself. That loader is
measured as usual, and PCR 4 and the event log come out as for a good
boot: keys sealed to them unseal, and attestation passes.

No broken image is needed for that. An application whose Subsystem
field holds a value U-Boot does not know, say 3, is loaded all the
same (efi_set_code_and_data_type() logs "invalid image type" and gives
it an application's memory types), tcg2_measure_pe_image() returns
EFI_UNSUPPORTED before hashing it, and efi_load_pe() goes on. On
sandbox, LoadImage() of such an image returns EFI_SUCCESS and leaves
PCR 4 as it was, while the same image with subsystem 10 extends it.
efi_start_image() then skips efi_tcg2_measure_efi_app_invocation() as
well, since its image_type is not IMAGE_SUBSYSTEM_EFI_APPLICATION, so
the "Calling EFI Application from Boot Option" event and the separators
are measured only once it starts the real loader, as when U-Boot starts
that loader directly.

With Secure Boot on, the patch changes nothing in practice: such an
image fails efi_image_authenticate(), since the Subsystem field is
covered by the signature and an image efi_image_parse() rejects fails
it too, so it is never started. It matters with measured boot and no
Secure Boot, which is common on boards where nobody provisions Secure
Boot keys: disk keys sealed to PCRs (systemd-cryptenroll --tpm2-pcrs,
Clevis) and remote attestation (Keylime) rely on the measurements, not
on Secure Boot. There an attacker who can write to the ESP can run what
they like, but it is measured and the seal breaks; an image that
escapes the measurement leaves the seal intact.

> Doesn't EDKII also disable the TPM if Tcg2HashLogExtendEvent fails? So
> does it allow to load further images without measuring if the
> measurements fail?

Only when the TPM itself fails. Tcg2HashLogExtendEvent() in Tcg2Dxe
clears TPMPresentFlag when MeasurePeImageAndExtend() returns
EFI_DEVICE_ERROR, and reports a TPM interface error. Even then the
image being measured is not loaded: DxeTpm2MeasureBootHandler() returns
the error, and CoreLoadImage() fails on any error of a security handler
but EFI_SECURITY_VIOLATION. Later images do load unmeasured, as on a
platform without a TPM, but nothing is extended any more, so the PCRs
stop short of a good boot's values and sealed keys fail. That is the
case the OS catches.

An image EDK2 cannot measure because of what it is, one that
PeCoffLoaderGetImageInfo() rejects or whose subsystem
Tcg2MeasurePeImage() does not know, gets an error that leaves the TPM
on, and is refused the same way. So EDK2 does not start an image it
failed to measure while later measurements still work, and that is
what this patch stops U-Boot from doing. On a TPM error, the patch
refuses the image as EDK2 does.

In v2 I will name the subsystem case in the commit message and add it
to the unit test, and carry your Reviewed-by on 01 and 03.

Thanks,
Ana
