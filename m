Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A83F606A7F5
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KzB1qWRV;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Lgw1QUMr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 118E280D7F;
	Tue, 27 Oct 2026 11:46:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwC_qnz8XuvS; Tue, 27 Oct 2026 11:46:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 274C280D59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101598;
	b=UjDBjRflzxHUXgv5DEiSwX5vdVuoSBZG6w+C9YdAVarAGttdOuUPphwE3PPSv7LjBF6Q
	 GhLK42+C9fN8EkwE+vOXHmEJLuTPqORVlDQgWYxGMbqhvVy2sSjfdpTBWZ+3DMQWbZ09i
	 1z20AndJ3GCtj2JzcRYZXcxF4m8BwsxZjdOrNvBvVdoeK8Dv6uP//6iXRneLxeEGWSsGm
	 puR+mMPrLq8HXbH99Fi/eYvKT4ysu3xD+hM+cw0NA8E5HM3Z8y+f680eTaDGxHPciBezh
	 l8eKCh+RcPNS8ia3qJta3iYfZ5V0Z3F1ftJkJ0meLwzufE0rHPoXTsqqqQtJfr0/Low==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793101598;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1q7ixz2WYxKZO8p/Oo/SBydB6gJR+ynFf2Q+v6Y+Ta8=;
	b=MjP2tPQ8HcUg4oPlonmpiBYtmF/GXTbxL6drUjIWSHdrrpe8hcST9bIOGooK7kbypxZQ
	 Bmo0pmxvPBarMi+Nq6NVBexD/qlW2TV3ME90eO8cG95ULbB//vLSHsQ9KyrUlhnBxZp8Y
	 CzftluYmA6eg7MwG88rXqV14cm60XbFgbZUalkN3Ku4JMwsSeSN44q7twBMI+43ZCr13e
	 nWyZq0vJ7JpVpmvWzp6R0D/DpaH3I4q777K+opfUyw8jotb9eKN7fMrztMSWq+vvnCeyK
	 1ojWafAQYRCY2KTdCzlELBahqjcPbnZb2p4qBHpLbmNuO4s8daN45tstXjNfou7TEcw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793101598;
	bh=1q7ixz2WYxKZO8p/Oo/SBydB6gJR+ynFf2Q+v6Y+Ta8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KzB1qWRVZM1sPcHbci+5+l9wJvs8S3di5NVcIyKwmWjn6f7wMLv7oV/VnzXWCSXoz
	 268+pPGvY5gZfYcQ5brMzgzros+J14J+o/XlCc9+nLklhQyn6QA7AgHfVf9LRf8zgg
	 /YMi+o4PeBdqqBNIsGo1z7hveOXFP3zhY8S+UKEt8uBbfQlqevJU/yOc6oPh3/Vt6Z
	 Mypk1eBKPlropTKXLZBuyFcheEsd68emPCKgHJfJAllx83Tt73cyJppJUm+Ymbrb+G
	 HjY7qwNrZij3q2qrc1pYitRFHtd2JPBmpixsfoGaCzn9zfEXRJWsPj/HyZ9+iLROPw
	 m9briI0i15+XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 274C280D59;
	Tue, 27 Oct 2026 11:46:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CBF9235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:46:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 527FA60711
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:46:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpVpNPapwpwO for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 11:46:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2336A60708
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793101595;
 b=PtKolupxT+8mPLIn1EMjw/l4lqZOVwjTqsI8GZ6WkqXlFrCL2pnClERJ1QXW26eGTxtM
 OWRnQB0l/u/Zaiuv5erM5fNMhrC+7vyDAUEfwqHUSRgayiluPwwyfek5Hqb6rt9SPYsic
 i9jPWHzEWcX2gDD7b+l42uYy6SClDsJLxPAON51X96opBmLmbDrPhIbzQ6FnDka3Jv3vP
 vo+qJ9fRrwPjgNq0UvyKgDPB7mZaloGurvzZazzaWkeVCc62mVUSZWYD26LdCBP5B3YYN
 kyQcpByM9dVUoKG/5WO/2dUnWmzZkIedRWW+ID2UwughnDREkqlGBowe+JIyBIZCvXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793101595;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=1q7ixz2WYxKZO8p/Oo/SBydB6gJR+ynFf2Q+v6Y+Ta8=;
 b=lCaprUzjXl3uoTVrJf58kEMz1RE0WN5EWX+b/nWR0FAlrv3MtX4Pssrcldv6VE4ZyAi4
 U59o6Vz6nr3vnziQGGbSLHRJOlo5XiV1K5AkdUkiAull9Qai8NYIEnlVbNPasyUmIjhOM
 sGvbTlj3rj2VteZ4R2085axIhHg6NXiZ7I+NoItWfBjItri7gGDVsN4ks+B3XNew4kWvT
 JaFePlRjf0s0jkuwe5Azahx0HSDL5JbRuj4YqQQMQB1RDYBzaN/Q8YQ0dH89DxtOd/mA3
 rFwb7Ay7RGHwMFq9a1nM1zgMVhdXbwYFJYgKF9UiZqS0QBqApETl0zeeRTXjRs758Lw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Lgw1QUMr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Lgw1QUMr
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2336A60708
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 11:46:33 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ab38a051aaso38651387b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 04:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793101593; cv=none;
 d=google.com; s=arc-20260327;
 b=D4fkLTMg3bA8RuA8+aSgVxUuUYOZxW5W+gn3i05GQDpQxdasXDCofW0F7TuPcN9kJU
 FV19QnF0jo4AJbCUo3pg8VAGHYU2TgyHLgwZQh3jyLzzlSjfDfDiakSfJzvvRrk4+leZ
 94Zn95NVgXrFUG5Dj1A1Ar4R07QVboe9ur2XjXDTMunqEQuTXZE0BXxkw+eBaRvf5F33
 kxRj2keaL+TvKnKgu0CHVJuCyLP2EIvVVaUW7iTpz3ggZPw7Ux85A+i/64o8r2Y9SiqS
 R8kZCQ+ObWVgBQAmzziCg8BbPB8lT+JUpJMV8vYnJfK7PuygJgH5i1rLR9Kqf+uLbvB/
 hvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1q7ixz2WYxKZO8p/Oo/SBydB6gJR+ynFf2Q+v6Y+Ta8=;
 fh=dBPtYC1TZ/qisQKccqrPk+ZU1k6U81Ut+AAudAfs85g=;
 b=r9QYFYe47jmTOCECT7AU6V635j5/zV2bLXIWNuboNn/OHV1W5+XltP4s2bKdbhgEA8
 KQH7SyaMJAcRZXW6wMgkzv7Z6LYKJgEYkuMTeplZhoWrtjtRN5tLl6b+LpZ/TXQ4RaTW
 P6fBwnmjMNx/vAwEnj3blEHcoG+J9I/4nAjJhrZBzXOsiFUTwdaKuJyTLn9sn/oU9H4S
 GhA7+IakpQBva2V/Ph+MbjkImV3dZTjewtTInxAdLvqqIaEU4Wmqb+UkXu1i8f9AyyH3
 NPoRnynX43APSW2LV8ioKETqnFFa2+mUUL1TGQN8yBGyUF06wIr7Y/RteL+lgvRXR5xV
 0FOQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793101593; x=1793706393;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1q7ixz2WYxKZO8p/Oo/SBydB6gJR+ynFf2Q+v6Y+Ta8=;
 b=Lgw1QUMrbOULhv8+MkGAnLNAZ0fB8h3ut78h26+PnNszCRoTvAcK7g30QmwwbhW5zA
 gzHiyWwrhSgeBzMI/OQtWx+IG5x3F4HALKeT/oxOe7o70gGrvO/et8zNgVqzEgcWfn3A
 eFJ+zWaI3TdH07ozQzAtxb9KESLAoMSV7GNnEAi8YjoOMxZgNjwz/uj5HJ5ty2PEozlT
 PcZ6LubHAi1fL2yAE28ml3YdByqVtLc4qmg7fh4nGzVfkzaDBC4AzuytE/RQVfmyT9E4
 mi8bLBdxjgpBzR73vBRSgVhyjsZX/WWq+s8iFLTIHP3+8X1iKNisM3qha4mwTffK2UjA
 a/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101593; x=1793706393;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1q7ixz2WYxKZO8p/Oo/SBydB6gJR+ynFf2Q+v6Y+Ta8=;
 b=Vgj6NvMWzs34RvwjfVs5wjNUJePPI3BIWl3tpOD2aEFj8OmQj6gMN09dhI4zzAkTOJ
 wfE6OeFEJEKt9iH3WMToP0u9SjQlKPhEMWOJZ2pErIkVz1avyNID5o9yNxgX8CnzHcHO
 YG4EwVG2ABeA/Z4a/zZwRcQhANRAFiKEWcGRj6lcTopb9Q9cTc8hkJDiMGz5KY+DJtPx
 LfT/pcCVVis1P/jtdvqI4ZRQqiC2hxFSr9Mss24Eydpx/j3iRZfZgiXQboAVrF/00MNT
 b/yikq+StOi9tjk6LBfx8e9Bosa38LC7jG8dVpNxwFV88ek1jdo0Qp74tLvNYDYSFyKI
 OyOw==
X-Gm-Message-State: AFq9FYJcuIZaqWx8qYj3hTZY/2CmvQ3Od3vJss+C3oc8xsoPDn5GZwgE
 fgLWUnZpoo5xvFJwquMRQ738V2PJWTj8pVRu7E+xiPyPlczhQCd4ttHAxFMozOKBUyA1K+2YAnL
 Mu50Kdk41ki5ObXisJEyYhV5K9zGp64m7vkaZu3BQtw==
X-Gm-Gg: AYBFou1KU3+8tN6mHN6Ns6hlcI2QgChBx3T2sfqolDK8bN2B4fuiwD1FI+NLJ8FIcEv
 z7oIEMM7ZJlkQnCp9AAUJ7Z4kErebQaeh+wd84DvED7WOI9eV6gSPwyOCngg6WoQ5tLJ6oKkdty
 yPViGMQFxjTKhy2s9K/ZHNFqQvVZUCGHE+WR7hiW83bnuc17jwPgpfjFSwmDaHVmbr4ZR7UU5vj
 1KTUg7V7YClBR1YjAUz7fG0m77gAAbMYUvR63JEVQ16Ypq2ZK7qFO93R3Phf8wnXKuJTX128HoQ
 hWB59dhAwXgUOHB9iTG/pxGwvLxCOFoF4M2BncsUb/UOvlFn8AG4iY5+zzb+EHhgrCpcZYZNH7R
 FJHWamXrdA1x4Gw88CWcMBOJRX+9ocSx9A/Y3ffvwH7IICtOM9oVU/D8y1FheyhhLxIxsnhw/p5
 wbw8leT/ibzm7ZgGt502epi9Ow4FRjQJF+hHRmE332zr0bnHrkLy8ZJwojq0Ax19xZxC0Gnyy6C
 DxJekPaVjSMqNTv+yDuz/ac8B2DAjLy3oYIzV9yCLtm9KRYYz/ZDd99JjuB7A2f9tWxQskctOCF
 s3fguPA0K2qbSnGRUN1KpfE9RK4zDmGWUWQgBubd/jL2jisZ/68d24lXCJQQ+I9G6P3Oi5KsDvu
 9dYiPqMTFtV/ze7HSBoMeQrPl3ZO+fdJL3sFQQnIr8SBD5B8/SVb2c6C5+vlhj0gvXIFXP9NSsi
 qG+HPJksNkhgTHUHWnHwySnDo5Of/g1+r7JAQ=
X-Received: by 2002:a05:690c:a003:b0:897:73ed:dd25 with SMTP id
 00721157ae682-8b166bcc34dmr56613237b3.27.1793101592578; Tue, 27 Oct 2026
 04:46:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
 <c927a9789a43f0903237040cced800e077bea7c5.1792001844.git.harsimransingh.tungal@arm.com>
In-Reply-To: <c927a9789a43f0903237040cced800e077bea7c5.1792001844.git.harsimransingh.tungal@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Oct 2026 13:45:56 +0200
X-Gm-Features: AclHuK_Hkgbz6HDHaN_zNfwgzCa0R96Dj0n8KqFUQGf3gUM9bMTImhPYY388jYw
Message-ID: <CAC_iWj+yDFHL7AWT+z0caOWMPFWut7CkOX_2vJM5HW3xrU0-ow@mail.gmail.com>
Subject: Re: [PATCH v6 13/22] efi_loader: enable TEE runtime SetVariable()
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
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Harsimran,

[...]

> +       efi_status_t ret, mm_communicate_ret =3D EFI_SUCCESS;
> +       struct var_check_property var_property;
> +       struct smm_variable_access *var_acc;
> +       efi_uintn_t payload_size;
> +       efi_uintn_t name_size;
> +       u8 *comm_buf =3D NULL;
> +       bool ro;
> +
> +       if (!variable_name || variable_name[0] =3D=3D 0 || !guid)
> +               return EFI_INVALID_PARAMETER;
> +
> +       if (data_size > 0 && !data)
> +               return EFI_INVALID_PARAMETER;
> +
> +       /* Check payload size */
> +       name_size =3D u16_strsize(variable_name);
> +       payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + dat=
a_size;
> +       if (payload_size > max_payload_size)
> +               return EFI_INVALID_PARAMETER;
> +
> +       ro =3D !!(attributes & EFI_VARIABLE_READ_ONLY);
> +       attributes &=3D EFI_VARIABLE_MASK;
> +
> +       ret =3D get_property_int(variable_name, name_size, guid,
> +                              &var_property);
> +       if (ret !=3D EFI_SUCCESS)
> +               return ret;
> +
> +       if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY=
)
> +               return EFI_WRITE_PROTECTED;
> +
> +       comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
> +                               SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret)=
;
> +       if (!comm_buf)
> +               return ret;
> +
> +       /* Fill in contents */
> +       efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
> +       var_acc->data_size =3D data_size;
> +       var_acc->name_size =3D name_size;
> +       var_acc->attr =3D attributes;
> +       efi_memcpy_runtime(var_acc->name, variable_name, name_size);
> +       efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_si=
ze);
> +
> +       /* Communicate */
> +       ret =3D mm_communicate(comm_buf, payload_size);
> +       if (ret !=3D EFI_SUCCESS)
> +               mm_communicate_ret =3D ret;
> +
> +       if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_R=
EAD_ONLY)) {
> +               var_property.revision =3D VAR_CHECK_VARIABLE_PROPERTY_REV=
ISION;
> +               var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_RE=
AD_ONLY;
> +               var_property.attributes =3D attributes;
> +               var_property.minsize =3D 1;
> +               var_property.maxsize =3D data_size;
> +               ret =3D set_property_int(variable_name, name_size, guid, =
&var_property);
> +       }
> +
> +       return (mm_communicate_ret =3D=3D EFI_SUCCESS) ? ret : mm_communi=
cate_ret;
> +}
> +
> +/**
> + * efi_query_variable_info() - get information about EFI variables
> + *
> + * This function implements the QueryVariableInfo() runtime service.
> + *
> + * See the Unified Extensible Firmware Interface (UEFI) specification fo=
r
> + * details.
> + *
> + * @attributes:                         bitmask to select variables to b=
e
> + *                                      queried
> + * @maximum_variable_storage_size:      maximum size of storage area for=
 the
> + *                                      selected variable types
> + * @remaining_variable_storage_size:    remaining size of storage are fo=
r the
> + *                                      selected variable types
> + * @maximum_variable_size:              maximum size of a variable of th=
e
> + *                                      selected type
> + * Return:                              status code
> + */
> +efi_status_t EFIAPI __efi_runtime
> +efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storag=
e_size,
> +                               u64 *remain_variable_storage_size,
> +                               u64 *max_variable_size)
> +{
> +       return EFI_UNSUPPORTED;

This will lead to a compile time error
lib/efi_loader/efi_variable_tee.c:1179:1: error: redefinition of
=E2=80=98efi_query_variable_info_runtime=E2=80=99
 1179 | efi_query_variable_info_runtime(u32 attributes, u64
*max_variable_storage_size,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/efi_loader/efi_variable_tee.c:1074:1: note: previous definition of
=E2=80=98efi_query_variable_info_runtime=E2=80=99 with type =E2=80=98efi_st=
atus_t(u32,  u64 *,
u64 *, u64 *)=E2=80=99 {aka =E2=80=98long unsigned int(unsigned int,  long =
long
unsigned int *, long long unsigned int *, long long unsigned int *)=E2=80=
=99}
 1074 | efi_query_variable_info_runtime(u32 attributes, u64
*max_variable_storage_size,
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Is what I am getting locally.

Each patch needs to apply individually without breakage/errors.

Cheers
/Ilias
> +}
> +
> +/**
> + * efi_set_variable_runtime() - runtime implementation of SetVariable()
> + *
> + * This function implements the SetVariable() runtime service for OP-TEE
> + * without FF-A runtime transport.
> + *
> + * @variable_name:      name of the variable
> + * @guid:               vendor GUID
> + * @attributes:         attributes of the variable
> + * @data_size:          size of the buffer with the variable value
> + * @data:               buffer with the variable value
> + * Return:              status code
> + */
> +static efi_status_t __efi_runtime EFIAPI
>  efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
>                          u32 attributes, efi_uintn_t data_size,
>                          const void *data)
> @@ -1124,12 +1233,16 @@ void efi_variables_boot_exit_notify(void)
>         free(var_buf);
>
>         /* Update runtime service table */
> +       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
> +               efi_runtime_services.set_variable =3D efi_set_variable_ff=
a_runtime;
> +       } else {
> +               efi_runtime_services.set_variable =3D efi_set_variable_ru=
ntime;
> +       }
>         efi_runtime_services.query_variable_info =3D
>                         efi_query_variable_info_runtime;
>         efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>         efi_runtime_services.get_next_variable_name =3D
>                         efi_get_next_variable_name_runtime;
> -       efi_runtime_services.set_variable =3D efi_set_variable_runtime;
>         efi_update_table_header_crc32(&efi_runtime_services.hdr);
>
>         /* Record that ExitBootServices() has been called */
> --
> 2.43.0
>
