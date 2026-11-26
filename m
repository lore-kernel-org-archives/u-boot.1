Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A9606A329
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JOWddnPU;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dGQ2/H70
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AAE988104F;
	Thu, 26 Nov 2026 07:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BC4EbYzve0R6; Thu, 26 Nov 2026 07:47:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CCBFB81016
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795679235;
	b=cBHB6ckLT+H7BYQLpIdu1d1lW0J+x1J+3TGxigpzFfItzgUEbRjTWSUOoyR0tqTMjbnj
	 kdQ/wK2WDrbnO7weLMd3n9U/bSQJtAsHAbo7pT4lhHzz8bybrttHcZwur3BcAEpQ99ag6
	 VPI4Lm5H/cpd7W2rFQysm89/dmptRNqOhKMo/dk3nnskfIEo+Ikpjugf9kqtnQjPEXtsB
	 P1DH2AsetF0qllkwhBWWGaDHeDMvXaI6SIpZN5KaK0jGOHju23LLLEw//m+Biic+wMikK
	 ChzSkjN5pokluSUSGCIYtWQISbxubFh+DOGnsy1JdY2z3kP2ASt26LCbS8HQJ9WnShA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795679235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2VQFrgaF4tCsiS1Dvm3IWE6cD2inPVYzMGgAc8jAZ5c=;
	b=H1cgn+yL/ZgPfXUSKBsVEEStBXkCW0WgbOjcfVKSw6s9R/y/ARD4NEEkd8xu3KKs+D+S
	 d9tym5fh0njunmRvhKnAqCz4L/vdWB16JstB24hJ8KmXXzvCpSWLT69nhuil503J2jzZc
	 OeGacPlmwmPO0shsGFJNClrLlBbTrkti7z2jD658wUMkWesa8xC1E8f4EMuo542zsRMLV
	 9/QTxct3ru1ThH8n3BMo/7qIVhKOGdn18P4SyZ86sw8pjTQkn8lYJFtscWloLFzVBz+nN
	 uUpuuV7mf07egnfvbjrL3wYMFEvZyGIHXrEaJisUzgcROF8xToVJrASMNXxUERS7prg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795679235;
	bh=2VQFrgaF4tCsiS1Dvm3IWE6cD2inPVYzMGgAc8jAZ5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JOWddnPUY5+ogj+bJ4rnpVA5+SSbDmzVkbRby5OyOxphNCqbcgO2LJpwxy+YAANGf
	 KHaylBlcX7uiuhSviFAB6VGGehD2PeHEu6EbvsDtKWYioutrbOVyOjkBXZZ2Rmw4e0
	 bwddRNwruAgYqQou4X0HVfKpIm+OxBHrS+sLr+IhxxlpIeR1CIuQdvcG5HKs+bZkNx
	 oPF5issAtX1SkGGzmSZFacdyqBvdhTBNl7NXVab2RQnhM/ABSXiV9eyhwX6wCA8BAT
	 Dg8A2Bi722xeojAjjZyw3hKWCOKQMDdYN/HyeH/Zl3sk43iO4p7dc6s/HR/dUtWD89
	 9tghF5vcaGqgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CCBFB81016;
	Thu, 26 Nov 2026 07:47:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 987E01C9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89BDA40859
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:47:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8tMNf2XJlvIu for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:47:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7B1D040854
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12a; helo=mail-yx1-xb12a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dGQ2/H70
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B1D040854
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:47:11 +0000 (UTC)
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-67db3a48dc6so8026472d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 23:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795679231; x=1796284031;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2VQFrgaF4tCsiS1Dvm3IWE6cD2inPVYzMGgAc8jAZ5c=;
 b=dGQ2/H70pgwKH/ZxCWO2ArC2BYPUKPLZUvDjmZn5zDpoQxNFeyjw0RE7K3Xaprtk+3
 vP9C8jJ+SlOUumSU+YdJvKRPmji2I7jVDCaQjgqIZqkSrLnp6oRooNqF4JNFPEVuopOv
 jh5XuqVSnXXnHSjGOfdZPy723Su1A+umWwjM7TejLltVELPvOcDbKdt45/i49xj7iqzs
 a0AEAD00WwsAeVQOhHjIiWPjbV5v2iwwrESEFto6kNFHc+wAgB1ldbBkeKX4ejN82T0G
 8RumqbX+Yi4TA8CQqlvsktUqvYOEXYY6hXYSbulusRjOSfxN6kSnvwTsyAoStmcbhWH8
 9TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795679231; x=1796284031;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2VQFrgaF4tCsiS1Dvm3IWE6cD2inPVYzMGgAc8jAZ5c=;
 b=BQzRDqgbRiAs1pgkMecFT1yA5p2Uaut3e4mcau1mKT/GS7GQg7fMZj+Yt0mkpKYETw
 tzbOC3v9R+UJEW0igD16NaXlTuDyw7rNv0eb4FgWV9NWIx6qNwxYzKEQoFGPPpy8lp5N
 StTwMFepDWYzvDw9t+TFe0zMRliMy2xi39PuqtnRzah7zBZgbP9/T1t0CXxFfbuOq3rQ
 bV2rtNxU7iUvMra6I5uo3NVKdqDO6Ow45PDnbJw0MLKOYQaJzX4w1D752yzDXJR5g6Vo
 Oe1q8T4oko8Ql8dfi7QD2KD+lLcFNLhoRX6sYZbOCRZAZ5s/EUa9vUPqb9JHRTiy/V0m
 +IOg==
X-Gm-Message-State: APuU4Z8zKFtCRX2T+bdaHW+ARWOx8KVFRxgjv0glkuLpwARgKC9Y8FqG
 q8i0rjrZFG+yNgMbAv1vBqaO7N7Tb+/O1OEBvOvWlbeRmnx3MdwVw1vzug61fl7T9P/yQ+2Ougd
 XuELiHSi0Qlgi36wos5qk0z6GiD1zafQbUY77yw/VFirF8DqR8O9e26QjSw==
X-Gm-Gg: AZFdTZeH10XoEDyDqIim41mB0CA4WinWBO0PNHzOJXoVprL6Av6zcPhDThih5oRXwx4
 QeAATafc/oz3lFd5ICu8+TnS+o3hTIs8d8BC2HryJ6namtTorTMYd6pWklBYUpJbk87n3va/6ih
 DhfwO/wJNRPOj+MLEEa8gnMUM72X/whuSJYfZKS67olIKMkhfMb6HEpvRbxPxvDHHJkamDo8/Hs
 720f2qic9cgJ3EaAaeCjAep7pBiIiRzHuBNgcCEGyDKW1UCnxhrGoRrgMRaFom0Kus0OYzZeFmh
 iH59I7JIvBoO7bx4MuczLvlTrgFz5E6dzTaEEsdvuuAbA1SMRy3tFrzOux3rdJIkAx8v5MwGsjA
 NP1TFUG04lBYnZTVE9g3vaxknU2ovdcAUBem18J8eyV/7zB4S/3Lz6/O285uaNKXkap/tfmakfU
 MkElQeJWTaXekkXX4P7LV0rdBQWVOvQG/WKHirkE+MmH9zynCVAjL1dNwZnYOYav3tYY7m5/aG3
 Ku4uoi8Ym0iW7Xg6jok24kV+zz/tGwqjGuoYbAXs5VgFoMc24SHBlTGIw0n7a1XO/0pzrGtxMpS
 fDyycHfh9jWdH7THFnIeWpgfH9pJ+liamTRp+kuKaUifKvTL0Mj2QPjk7XPkLgXFswxFDVwT9RF
 AkwjSTr6036lOwlOara0pxQ95iaHR6ic8Jo5aORZpUU+7ycVN9iyddbNbHKNLVlm5DJHyH4xEAO
 CFbYTcsc599uMrIKlkQm9Xm+3t4fGPaBabqmYUA/WamNXJa634oOwPXFVdpBF3jEnQAHRrXm0=
X-Received: by 2002:a05:690e:1407:b0:67d:a95e:27d2 with SMTP id
 956f58d0204a3-67df4443581mr8722400d50.84.1795679230763; Wed, 25 Nov 2026
 23:47:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-fix_tools_fwumdata-v2-1-ce6c95f40988@foss.st.com>
In-Reply-To: <20261119-fix_tools_fwumdata-v2-1-ce6c95f40988@foss.st.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 09:46:34 +0200
X-Gm-Features: Aa3M54pCHAxNMhrqXh50dj4m01hQ5sHGEv4p3XARBoqN8pHflTpxoqLWgRkHmHU
Message-ID: <CAC_iWjKN+2igM5J2a+_n9muSPDWixaF28oWGtun8JOnWiJu_6Q@mail.gmail.com>
Subject: Re: [PATCH v2] tools: fwumdata: fix redundant metadata buffer overlap
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.u-boot-project.org, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Patric


> + * Return a pointer to metadata copy @id inside the contiguous buffer.
> + * Copies are laid out mdata_size bytes apart, which is not the same as
> + * sizeof(struct fwu_mdata): the latter only covers the common header, so
> + * indexing mdata as an array of struct fwu_mdata would make the copies
> + * overlap. Both copies are guaranteed to share the same size (checked in
> + * parse_config()).
> + */
> +static struct fwu_mdata *mdata_copy(int id)
> +{
> +       return (struct fwu_mdata *)((u8 *)mdata + id * devices[0].mdata_size);
> +}

The patch seems correct, but the naming here is confusing. This is not
copying anything, it just returns a ptr to the correct mdata offset.
So perhaps mdata_get_copy()?

With that
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> +
>  static int read_one_metadata(int mdata_id, size_t size)
>  {
> +       struct fwu_mdata *md = mdata_copy(mdata_id);
>         int ret;
>
>         ret = open_device(&devices[mdata_id]);
>         if (ret)
>                 return ret;
>
> -       ret = read_device(&devices[mdata_id], &mdata[mdata_id], size);
> +       ret = read_device(&devices[mdata_id], md, size);
>         if (ret)
>                 return ret;
>
> -       if (mdata[mdata_id].version != 1 && mdata[mdata_id].version != 2) {
> +       if (md->version != 1 && md->version != 2) {
>                 fprintf(stderr, "Invalid metadata %d version: %u\n",
> -                       mdata_id, mdata[mdata_id].version);
> +                       mdata_id, md->version);
>         }
>
>         return 0;
> @@ -283,12 +297,12 @@ static int read_metadata(bool update)
>         if (ret)
>                 return ret;
>
> -       if (validate_crc(&mdata[0], alloc_size) < 0) {
> +       if (validate_crc(mdata_copy(0), alloc_size) < 0) {
>                 fprintf(stderr,
>                         "Warning: Primary metadata CRC validation failed\n");
>                 mdata_mod = update;
>         } else {
> -               valid_mdata = &mdata[0];
> +               valid_mdata = mdata_copy(0);
>         }
>
>         if (have_redundant) {
> @@ -296,16 +310,17 @@ static int read_metadata(bool update)
>                 if (ret)
>                         return ret;
>
> -               if (validate_crc(&mdata[1], alloc_size) < 0) {
> +               if (validate_crc(mdata_copy(1), alloc_size) < 0) {
>                         fprintf(stderr,
>                                 "Warning: Secondary metadata CRC validation failed\n");
>                         mdata_mod = update;
> -               } else if (valid_mdata && mdata[0].crc32 != mdata[1].crc32) {
> +               } else if (valid_mdata &&
> +                          mdata_copy(0)->crc32 != mdata_copy(1)->crc32) {
>                         fprintf(stderr,
>                                 "Metadatas valid but not equal, use first one as default\n");
>                         mdata_mod = update;
>                 } else {
> -                       valid_mdata = &mdata[1];
> +                       valid_mdata = mdata_copy(1);
>                 }
>         }
>
> @@ -313,7 +328,7 @@ static int read_metadata(bool update)
>                 fprintf(stderr,
>                         "No metadata valid, use first one as default\n");
>                 mdata_mod = update;
> -               valid_mdata = &mdata[0];
> +               valid_mdata = mdata_copy(0);
>         }
>
>         if (valid_mdata->version == 2) {
>
> ---
> base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
> change-id: 20260818-fix_tools_fwumdata-cbef1098ff7e
>
> Best regards,
> --
> Patrice Chotard <patrice.chotard@foss.st.com>
>
