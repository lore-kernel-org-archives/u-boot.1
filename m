Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162FB606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ClVsokwc;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Nz/jdC9n
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A16B6077A;
	Mon,  2 Nov 2026 21:01:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-K6z1V0naEr; Mon,  2 Nov 2026 21:01:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 397D7606A3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793653260;
	b=cFRVOFqa3N05RQ8iTJvDFQamf4Z/wTM+GC2gMthQms+merTVE50AWidiKX5jumHKjp35
	 FKvCNsAO3ZD3QQusjkCkwC+3dKgzw+k/YiwscEnqtV7JRQmE0o7r5KbMULrcl4rI2pl/R
	 QWI1eMcc11GNc3hQbnhkzVwC6VBBUl1qDODfEjhmOSLrs/W3ueVgpELGHXdSZyqMDGsK/
	 kzxmmj2a+Xxj5WXLYgwIp4crqaIHCFnDpELW9Sfu14CmpDg5VbKWDUlVhNu5MdHYzWJdu
	 L9wvBiLMcnCzYSUz4TOGv8HbcNm+wvUK7fHEKxiXDJVc2Fzf1Tm/e8PHGbGLagUxjPg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793653260;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v8Zmj7qiUmzk90RE024dNa4UCntt5y6Am4RE9sKmu+8=;
	b=dAAYiAC15MDdNjuO/x5JzdAPpYGEKeZ77gewdd4x5inKnJk3AFMM90RqaqnbaQLhHed8
	 VwZ3o2riYCEOgW9pEMSk8eluwmBJgxlcJgqDHDFVn4kOvZuHJiXqM/QB3ZfVAOHASTeZX
	 YqD6rjftAyzXCJ+yF/lu0zakLt9jb28P2OTqZuTP831ia1hyU9F832+88LaxexV0NJGRO
	 SlT8E//JtGPQFM9j7+SRntGixFuR08OuuSuXjW1H+XtBbH6KhqICU7orZjF46LBlR/Fln
	 UUtyLmDkIb0vAqCadS3oIAbHi7eJnbKP48pumOvfssZ5ugZ74/ysy5jZsSWvSE5cuqg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793653260;
	bh=v8Zmj7qiUmzk90RE024dNa4UCntt5y6Am4RE9sKmu+8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ClVsokwcMG4mCZfHduGnBxN0W4Uvvx2TV4IXVLkxJGoOyhnJMasDvAKNnnpcKnqhN
	 PM4jXkIiMLroyWBPg6L8RFiICvFDWR7rHriv6tikBYCyt/yiaHOLPDPlRqflUDl3Db
	 Ddhl7HHFmqskNtQXpjqtW81X26xk8xFSZO97XOFqsi2cskNxlFAySYpFpu4VAzxk5J
	 wnrFBHcDAAGfwrcf5MD3nLWo9L2xUyyDGRHIBKGgpqhgn/Nf395RYC8n0dNJXb3NBK
	 2GJK5zTMU6pNmP2iXglJlg2fvVGSKtg2zPYnUJvxJ0flxsGOEXfyD0ZYdH5nZVP3Ir
	 YwfaFyMUsCbzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 397D7606A3;
	Mon,  2 Nov 2026 21:01:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0026E356
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 21:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D93D280D62
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 21:00:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cw8ZRjUU6iCU for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 21:00:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84A8C80974
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793653258;
 b=NYH6nOEkZyDBcJbmXlWN+kcE1+vZ945aiJ8QG5B2OCJfx1FvQfZAnD21R1x3GyOtbkZV
 SXL25R7WVYv0N6jK1NosqU06Mfa6fsTJIryL1DhqEGX4SHNAE4ru/0szHqh0FQjBZ6+F6
 adEHk/WHKv9M5+64ankcyWVNdTSmzTvS8RdnQmw+LKCRLGYfhQBXr8vNtkunAeeutUaQU
 aFZmyh5IExeYdz6YJhwJ7h4aVU/BGIIptZPHCCCqFu2R9ChSdnV1lN6vio1SEp2gEQp/a
 mtcccVFGYk7LgAIKN/XfkwRn8rmJYcPuyiQX/wToc/XkQl6vRCRDxuy6/O1WsL8IXVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793653258;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=v8Zmj7qiUmzk90RE024dNa4UCntt5y6Am4RE9sKmu+8=;
 b=tdb+TbbMqYJ6V0Kj6La4QNuD77NJPzG/jFBGJpSLRpzNUFmoAlwr2UZLoVn8mCIg6P7g
 sxzhrsnGWxxpjLJ5ceqRWZ2UFzXpnSAa1nJJpR/fV51FbsO0azeWdRIynGRS88uSx1s1u
 zC3r1IAQoLNHK3eck2z2hRLFyS+AdfoyxQAW8duTCzVo5ScMwfXrk11cWKatg2eAQnE3j
 ZavxbyqSx9nFZgr3bd6T0dDyXdkrVO+FHwdWhLmeheocuK/BtakLmhTb/kRYJU7s4979I
 joHDkiMFyDVZyReMdZsVqO05xSGTVf36wkgr2qc8ZgVKEbmuLgysPgnNz3GF3Y42vSg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="Nz/jdC9n"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1134"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Nz/jdC9n
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84A8C80974
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 21:00:56 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b10ac6ab7bso29770307b3.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 13:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793653255; cv=none;
 d=google.com; s=arc-20260327;
 b=QVYuCVwZ5YbS6RxdFQ+cSFi2tXKsUzH7vecKZp/3eO+EeTvVSpsQ6NKOKWPpsBkZQc
 ZlWhlVXRfoxl3XOvs7dCMqnaN1TQhKfeOeo2zAKDfNFqiGZxv/ESYOEvYbHBDDiicQav
 kLhx3GvPFAiLjUYDNzakPF8Hl4MoFYRtHFPHZfbyRt9xAUZEUwjQuhHQS2GNHjrOV2mr
 80G7kGViEW3wYJyXRvB9+pbK4JgFmrW73NshlVZv0A3ZCNjFl1tbuJi+TyMSQ8bjhfh7
 AKKh0jGML3S9yb15BnKQu1LwMePXd+vwM0n3DINubCrH2gWj9+A8ptgI/cSqQLUlx8nU
 UBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v8Zmj7qiUmzk90RE024dNa4UCntt5y6Am4RE9sKmu+8=;
 fh=7QWwyUnPAQm5WNln6yz2UnPVMLv30rqCuNC8nkM6bR0=;
 b=KCZtjm/Or4/4cJ5b7VueFahqSONlELJdk0Jz9UOtkTQflsljb7EV3mWsD+STZ5JEeZ
 WXgqI7fRgUYmEC1eMnxphDjwZUtiiahhn03zafmWdjjDQRz3JGr/69AMWq/tRG6pLyfL
 mIDNFMRudevfKsYudVKQpVBlqzX0IA8/HsygUffZkLZHspmEd5C650K4tjeYCQVAF0MS
 XbkRr7XzN8rw3NC39dy6BmEldzrCQnD/9+2M/+NVoqJnsz/3/soV+4xjXt8B+MkROdMH
 CaUftZFBrYq1d2exiZVdOwZL5WoEMD5RVwiw/lW+WmKjEKuUXGyF6AJBv+GXnjqH1O1k
 E3EA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793653255; x=1794258055;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v8Zmj7qiUmzk90RE024dNa4UCntt5y6Am4RE9sKmu+8=;
 b=Nz/jdC9nJcoYJqQuNPexZM0rJYeuRO5kumpDkD0gT13OJY65xuIGZdfOP8Xn1Xe62t
 5iI7SSNdc2T0lW9DEG7BUxDdhoXdRUc9ZpdFc36fbbpFCSGU235nEEKxjQaFhH0cbgYj
 IJXsKHNTh0wlkRxUVEIArc1+qVDZwykP+e5YrXTfxlpJsj8CC/C59Go2qdCD04bfRDyT
 Qku2cx4rB4ZGQFwgZ9K9Zh92VDvrl/QhFfg+r+Yv5m+q591W2v79jT/LMhA5bduiKhgb
 yigoaXaMeGqbjrici9bAqtpQjUAGpetI5Rnxnlebx5vn9olDR0wEGEvmIknkTmlmfDxL
 daBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793653255; x=1794258055;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v8Zmj7qiUmzk90RE024dNa4UCntt5y6Am4RE9sKmu+8=;
 b=Kw3wc6zQ8yaAG0RgV0DIk1ThvoHMe1p62xONiv4QBQ6fbMsvCeLhc9QSs8USvOPqXr
 GO+n3M0fB9Chn0u99atjPi7RemxdQBGuzb1f1mjPEh/kzN4SczjDhFABdQXX+Y4KwygO
 9U2sSzRILNG7VfEpH6l5/i7E4ZSdnFngvVUJIYV+pXBnw/5KdTSWXC5H120n6O4prxMH
 S0ZmnfrZQPBWAbPBl7eCUTs0hI+EFdTvGPibrOiSdU5EqLk2LkuKcAA0jm859cFIwc44
 wzTkg/R+YGo4LA+3dEacukm2jmKhDCNxAv4n5UpjLJyWmFk/TwYDF3OFMvZ0Beu8KiCt
 clDA==
X-Gm-Message-State: APuU4Z/BF8sbJDWIHS+FFY1Rz2yZ76y4q93dSc9DRjyf2xibQXQWwvn0
 KZO2oDjVF0trPya1Plh3FBAWUjEwhCEc8PmoAv9EenFrJkf4SZxWXQ4pfIGMz0tRerTlw3DnLod
 RRJOaU/P57/zXfdXxjcseZajXXxdD/4OtH2dw4EymDQ==
X-Gm-Gg: AYBFou1+T4PZewAT/tYvpH737OCvrQjLFXtpPMg7w0L1QSygn8eIWdWWh4eeHmJ0IZP
 rgVL7GmiLYM+P6Q4K4aakmRx3AJlQLPwExSKoY75L9FN3oSOX8NfQn6vRf/Hc7mbQ5bAAygw2Yk
 CDsEZShKNEli0x6f45iVafqIQmySdor9SANNEZlJkLWC+Og3giGOGY7JKdsAfgS790VIxtcez3e
 0FTf4fMvt2GUP4B8ja96us5lVhwdtQIrRZdDu/CG8Fn9/Nm8bakzcXduaw3ZC2pHqDz6ZVSMbFl
 mPg/wdzrKj8wc4rC5Xb0f2YYvY4THTJq1NrmrzTHzlQY/kQoewcZ7R/IHqUjEhb4rFshyaH0THK
 CZ+ZvPj2F+0dBR1ES2PxpO8GLIPVN+exQi++UKlxrEx30xX5vCZ7aHTReBEliHZtMY6rpb/neYK
 +fbB3MODtiUovysVe0JqfFq3DuebkCukWIZDKrtUjVOQdgHlwbfB1Dkp6OSoArt3wbmTk3GmwzM
 cFZGp98UNmp19ssxKN+yctX1AbbNg9gWLnJUqzrkxblvkaKOWgJdWxKntqNG0gFoZCJG4YnwDnO
 5aZ0T7V19FNUs7Ki50ERKxBb/46mi+vrjQZUWm8zykSU3cFyVCU6yTACBXoSXPoheNYF1nZuoF7
 AZtOHhPRVrtqCKX2OYFSh4n1ZOA9iGBkjWVYArlHbBh+tSSUznLorBcsjqOVFp+WF4mVkAq4hzm
 3wb8my6NMy8t4nALCzhAOwvHXuFDZC2VxhX58=
X-Received: by 2002:a05:690c:660c:b0:8b1:58f8:9137 with SMTP id
 00721157ae682-8b2b67a7b9bmr58950987b3.57.1793653255294; Mon, 02 Nov 2026
 13:00:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-6-tkirchner@emlix.com>
 <CAC_iWjLX_3RAzxeCy7HQHEy+fZS4Jm-J_E6wnv_QG5+DWpX+GQ@mail.gmail.com>
 <64f49638-bcf8-45ca-bf88-2e96e2d8d68c@emlix.com>
In-Reply-To: <64f49638-bcf8-45ca-bf88-2e96e2d8d68c@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 2 Nov 2026 23:00:18 +0200
X-Gm-Features: AclHuK-q7r1rhlc_OKWvUFPylEoQe8lufVfx271W0XFnFxlWSTEvUiULmeTBtOU
Message-ID: <CAC_iWjLwGpmX3jfeo2h=ERDuYZo-a5scgBejzV_euCgazHimQA@mail.gmail.com>
Subject: Re: [PATCH 5/5] tpm: deactivate unsupported banks in tpm2_auto_start()
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 12:35, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> Hi Ilias,
>
> Thanks for the review!

yw

>
> Am 01.11.26 um 12:52 schrieb Ilias Apalodimas:
> > Yes, but users that will call measurement_init etc will have
> > initialized the TPM.
> > The PCR code exists because some users want to use the TPM only as an R=
NG.
>
> My use case is a custom measurement implementation on top of
> lib/tpm-v2.c, which cannot use the tcg2_* functions. So
> tcg2_log_prepare_buffer() never runs for us, and nothing makes sure
> the unsupported banks are deactivated. I think the low-level API
> together with CONFIG_TPM_PCR_ALLOCATE should be able to handle this.

Yep, I like where this is going.

>
> Regarding RNG-only users: TPM_PCR_ALLOCATE depends on MEASURED_BOOT ||
> EFI_TCG2_PROTOCOL and is off by default. Its help text states that
> U-Boot sends a PCR allocate and reboots, without specifying at which
> point during boot. So a board enabling it opts in to that reboot. With
> MEASURED_BOOT, the first measurement resets the board anyway (with
> patches 1-4). With only EFI_TCG2_PROTOCOL, the reset currently happens
> once the EFI subsystem is initialised; boards which boot without EFI do
> not get it today, but arguably should, if they enabled
> TPM_PCR_ALLOCATE.

Yes they should.

>
> > IIRC we can't get rid of the EFI call, because it's there to configure
> > algos that where handed over to us from a previous stage loader that
> > only handed us an EventLog.
>
> Agreed, that call needs to stay, since only there the banks can be
> aligned with the event log.
>
> > Can't we fet rid of it in pcr_extend though?
>
> I would rather keep it as a fallback: callers may use tpm2_startup()
> directly instead of tpm_auto_start(), e.g. custom board code or
> "tpm2 startup" followed by "tpm2 pcr_extend" on the command line. For
> them, the check in tpm2_pcr_extend() is the only place where active
> unsupported banks are caught. With patch 4, it only deactivates the
> unsupported banks, and only with CONFIG_TPM_PCR_ALLOCATE.

Yes that's what I was implying, but I wasn't very clear. Is there a
reason we can't move it to tpm2_startup()? tpm_auto_start() is calling
it anyway unless it's already initialized.

Cheers
/Ilias

>
> Thanks,
> Tycho
>
>
>
> >>
> >>   tcg2_create_digest: unsupported algorithm 28
> >>   Cannot extend PCRs if all the TPM enabled algorithms are not support=
ed
> >>
> >> Deactivate them in tpm2_auto_start() already, before anything gets
> >> measured. If this fails, e.g. because the TPM refuses the allocation o=
r
> >> no supported bank would remain active, return an error. The rationale
> >> is that with CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to
> >> manage the banks, so fail early instead of at the first PCR extend.
> >> This is in line with the TPM_PCR_ALLOCATE help text, which does not
> >> specify at which point during boot the allocation takes place.
> >>
> >> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> >> ---
> >>  lib/tpm-v2.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> >> index 18ec9eb960d..bd049fed748 100644
> >> --- a/lib/tpm-v2.c
> >> +++ b/lib/tpm-v2.c
> >> @@ -232,6 +232,18 @@ u32 tpm2_auto_start(struct udevice *dev)
> >>         if (rc)
> >>                 return rc;
> >>
> >> +       /*
> >> +        * Early deactivate active banks with unsupported algorithms. =
On success,
> >> +        * this resets the board.
> >> +        */
> >> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE)) {
> >> +               rc =3D tpm2_activate_banks(dev, 0);
> >> +               if (rc) {
> >> +                       log_err("TPM: failed to deactivate unsupported=
 banks\n");
> >> +                       return rc;
> >> +               }
> >> +       }
> >> +
> >>         return tpm2_update_active_banks(dev);
> >>  }
> >>
> >> --
> >> 2.47.3
> >>
>
> --
> M.Sc. Tycho Kirchner
>
> emlix GmbH
> Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
> Phone +49 (0)551 30664-0, e-mail info@emlix.com
> District Court of G=C3=B6ttingen, Registry Number HR B 3160
> Managing Directors: Heike Jordan, Dr. Uwe Kracke
> VAT ID No. DE 205 198 055
> Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
> Office Bonn: Bachstr. 6, 53115 Bonn, Germany
> Office M=C3=BCnchen: Am Knie 16, 81241 M=C3=BCnchen, Germany
> http://www.emlix.com
>
> emlix - your embedded Linux partner
>
