Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653B606A333
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bSlO6dKE;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Kqcb1flM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E979C4077B;
	Thu, 22 Oct 2026 09:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M18RzR36-Hnq; Thu, 22 Oct 2026 09:42:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E9E24090E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792662131;
	b=nf6FAptHB6nI4vv4ELdO0sKjz6VHL2kjNkfIUd7x1K5Y6/EYD4WYD2aktOfUF0KKiktb
	 0SDffyAWy54JUDRUCD7jN1IflyC2Gt9uz9sXWp8eZc+omnYMPgRAWcBB0cXMr5Iuex6qb
	 EPsMWXWPycqLFrajDVJOL6OHjjPU8lRxntjLte2hj7IrJdkY66Qf0NHwyBddnZpxoepPz
	 9VAw94wL1K5c8PbcyRJOpuel1p5dvhqx358y/xXhqgZU0BGkyptQUjdx2xohK70ME5Hi6
	 6GcZWsUM6fuPS9LPcKO60DRoi+2ddZFXj4LUPrJBoL8tRjSNYskH7f9qS6/e85CLHpg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792662131;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wj8MBa/3M8lrGygm1LOUtRdLCS/YWO7kqIdO8RHak50=;
	b=NV3dt7XJp62aUVu6YBJpr4enT/aKthL06aPnxRuxndwnRDVgI9CrZdpruh5JuhaMFte0
	 UoiWye8LXZlbIBfQQ+2kKYgJEFvJRBZeFImMflZu2MCUk8krl1R+FwaprL56xR9mzl0D5
	 VbYIpL9UZrFrlXB2AZuI+zZnabvO5Bb5CFccKNzNpmD6hjHIG+GOUJontFJbsaxhIWZKo
	 pJ40gy0lvlO4aT5th3WALbus2nv8ZTvE6oMjUp2G4TFNgPjqKeJrpJq/6/hBn0O2Ivz+N
	 b2eznoEf+P7fL2mHypqIMJl+W3eq/jhNyGSqg3t+jiAmnQGam3QcI6dHVzMGYnKBnsA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Kqcb1flM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792662131;
	bh=wj8MBa/3M8lrGygm1LOUtRdLCS/YWO7kqIdO8RHak50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bSlO6dKE3kGkTZpt8QYW5rZYC7KZ7PPLcoYRDfz+UVVaBYu77mol9lxnb9DqmBq7/
	 lG91yjiBh2HtHVweeTmcE0jSCbvxLvxpLtcKZYsf5asag4DK9/fr+e8O13jHVJYVOz
	 1zZQBoFhIA5k3rItiPtuU01/GmCIW9Rwg09HxuUGLbZuL/zwPSiJiemLrfWHQi+gLK
	 zDPRtRlHOUB32Fp3/pcwUYxS0bwir9LCbgRZvsWp2LhjhsFZ6JpZuhM2q3QyBSCHBS
	 4xs/ypo30SsL1ag8ETRQ6/iQAdGZHtvgrRAP47KEkqG9EGwoKyoUKXC4wWqdVEu0d0
	 axEbco99IPK4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E9E24090E;
	Thu, 22 Oct 2026 09:42:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B9972356
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B731D4090E
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlEzhNSPGQGZ for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:42:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EFB94077B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792662129;
 b=ra1aSBZKDv9YYAZsDfFGJboRmpnyfjicr4zpn5/K+BSynqZKRQ616nSdVpPjSGxpf1CB
 aKcuJB0xdnrIcwTqXw/FDjIdW6bCaaWYRZMrTb7+/xd0T+6QdqlUGW2+YdweLY9Cln28P
 QD5mZsw3Sj8000mRWyPHPlMg1cnaaSa6rN4Ro4OBKh7IiBsziRAc9+lddFreOKUE3yKY6
 2mrfE5tknCoTsLffZAgiiu4WdeozCjWJHWMeAhPIiCN9AXYvzVef1YzUdSvU4eHC7eJqn
 w/4+b6CXuF2HTNz6XFpXsn/6VBInpoMCxWeALJ6b3sAsD9tiKlsm4V/avvnpm0ADRLQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792662129;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=wj8MBa/3M8lrGygm1LOUtRdLCS/YWO7kqIdO8RHak50=;
 b=LCA+iqHRVxc1FkGwB2ieBS63B9jwROd6q037OD+/co7yvLMO5CN6KpL+M4bRaAX2UipW
 LF8uT0HLvdnIaVFxvavCN+nKyFr8LKSzADh69ym4WCqET5rxXPtR2zDdURp3+7e6aRo71
 pOwgTvivEUEfK8lrgkBVKm87hlXiV9Kk66Bw1i6POuAZQNvWc3Vqkhpjftp90RNObKqGF
 S6dQBs53jeEjZ2PRHJGeGfcf7vY4MIwQI5OFIJYK3yX/j7/3qvLpQFIFlbzd2QUUidh1C
 5cjA3MLm0e6tc5RfwV1yEyTrqZ2jjU+fRSHtf1au6+bh43x98jCYg6b6bWb/i+ROlbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Kqcb1flM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Kqcb1flM
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EFB94077B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:42:07 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8726acc5eadso15173287b3.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792662127; cv=none;
 d=google.com; s=arc-20260327;
 b=aG6KVKSHH9ZK5jylu3BxzHED9jJ+pqQZaJNAZQP8+QfzG6aWSb5oc9MgIG2ZpqOPAt
 Rynja6bKcXOdfRjchAzY3tY8qdEdRcy2VHvSg0621PQqNjghAka+uBq8IDcCr7TAvSfY
 EY9OPy0j9V+q7BLTMqPwARCRnd0eJkOgtU8n9fQaME/hmCb7d/c5B0ZAJlA8acJgcF+O
 0O8pvxwkff4fe5WqoTwjtHeZ7HKAwQnk3WpwEZnQlu2S4jUCZTzWeTsISeFHxEKCGtOj
 VlFCA6ZPuujz7xVO2wtSk35WFhaY5nnfM305oJ3XUZl95Qf9thzb9enSSME/cjDs9vQ/
 akXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wj8MBa/3M8lrGygm1LOUtRdLCS/YWO7kqIdO8RHak50=;
 fh=iKgM+FuDjQK4OI2nolAT9u8ho9hisYHu881P0Yp034M=;
 b=KaA0G00x1mM3NKThZbvG7eXeL2VPzaJaXI89agPPOd2Phgnhf+0n6NsnquPRudMOY5
 WE28fhwIU1WHTPP5hAmOctRM0N8ESDbSqaGMiuiEXOMplXHWQYyrmdUyX2RmVgp3qPlm
 f5sYmdtFQUL2vgtHLU7PTtgtynfdsi6MwZVZKsXUSbvL12nOEKQrlJwx8arlMzxzO2QP
 8wendLLBIMu8rtM0+iLtH5N+0zqkbcFk1DfeBZAkdAXXKjkXATX4Rnj0AeJSdHCNL/C6
 oqsSTHMa8Oral/lFUi9cz6/VszVRk3QY/KVUZNWu3z1tWR4u1csVcobe4IIV/hB3OhgL
 gaVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792662127; x=1793266927;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wj8MBa/3M8lrGygm1LOUtRdLCS/YWO7kqIdO8RHak50=;
 b=Kqcb1flMyG9fOQdaxY0oFFT/g9a6pSh73DgwczZNYQzsiPpkeFjLu20THdST1jAUFq
 XiptvH4CpkxoHAGeTwaiBjnCuOKx8lmsq5hagyg8yaebwg4+nazSx8dTT4q5PyvcV/fo
 RXc4F+QwN8YEn2lwhl6M3v2nQFWkwy3MlTmutCabdkOCRagm6AuYUikvdmC4c12M4PD2
 MDiV4ylXA9ZnLurvVLy53iLWYnNgOiOmmPnl94vSM4p4VH0lIdgYju+3xWTpRNOuwt7U
 bOEaakT8CZOXAappEVqEi9+kkxXVVgBTYpqM/oZyebkfLYRDQ35ryiisOfTMUqO7Uj+3
 geRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792662127; x=1793266927;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wj8MBa/3M8lrGygm1LOUtRdLCS/YWO7kqIdO8RHak50=;
 b=Jw77SfjmuW+lQQdUFWEkirOWt1THaxTclDG+OyFpzpXqa3nYH28qIfWNx2a5eYq+1X
 VnZsk8unX41nz3dPmMdz8oNslr9vcS+WYY0qoUSPNQXcGnKISzIw+Xa4lbtptS+7SKy7
 OzFXpHir14MHDscI2suwSoc47pkDuqu86m6TUtC6SKgdhxCjKNg+32xuw/4iCM9O6TSd
 WDHlxUADjgyKocOSKnxAnJl2bHoQ31bcMjBO8bHvvUhstDg0w5z+SzfhAoJ3MB8bBjRD
 W+n4Yzci3DUdf+OWIu6rJy98ppclq7b00tzymS9LKPWiBqqeA7AfaimDMToAOKPIs/28
 u6zQ==
X-Gm-Message-State: AFq9FYLKI4oS6rx6fQxXQYfLI5EdrDCO6U1PrO9mfuFVviIavjJOOwP0
 /Rfpcs5yAVnEQoHJdXqAjXvv8MBh7aZFRqT/UGD5SAoHo3jFK7+VOR+NX5c9hDEHhoixSaNVH8o
 GqIMBkcXH0pr29GL1sCr3QQzwXFC0aOpVN424RAYTqw==
X-Gm-Gg: AYBFou04tNZlvWdyCmB/vwY30up8E4mwkNiuuLyYgp6PEpFFj84VGg6qSwiGRGgd11V
 o5eUg0d3Enm9LQj+SnpB5ZfKaqf7hWC7QACDmAiM9Tir5WfW3Ych6cTgP4181u3BUzNVf0satYk
 vozh/eocp4BZyjm9npmx3ckmQKTE9ldTIbdf+Sj1lRIQsS8CTcUeLhWohcmmfSeLeA17h9ROtb6
 Euvs7sINd4aK8PqvHfQO8Qxp9A/o8M84zLPAvw4TzbuWSGdP7ke3rs8T7CyJTIhIYrYBm5QaSmJ
 gXWkYU7Xiay2+whrehwLlXI+YK7L6L1WF5Fmh4cnHw0Y4QgyFF8BUGC7KlrUy2GmoVNnFx0sRTk
 8sPJ5dpv+ha2FoFGtpjiZkU7k1T1LMAk7XEw0MDMi3CGPoZkjf73Ert6tQz499u+N9hoKlCZ1SQ
 WmqNbmAqOxMc4kqRnh4y6aHoJ1aTIdeEz7tOaFMHk3vTK57gPtXUEbNyxffmCNzTh5j4iUi7+n1
 FapFttMkqG2HaiJIskWYG3y79lxV5Ej8+Bb1Fc7W+XO2x5b4QwnVhsudxCqZoPOf3iSnTHS7+aF
 gebIOuZY9sz9FjPMnucvKHTtyvzMBHNQXQ+aEW0G+35G827ySxjuT4XezZneR+h0Xe/jGQkid5C
 Zyw0wDfr/U7zs3hvAA6iKfJY1JKxbng5SKZBJtYKNZspGZzaYn1UHCzeTz6McTXvoUcTYPv/RSK
 29hjHIBDtznUqir23/gl4UhJ4H6AAp3td8rOcDrsp+VFjtmMS88hyf1eVv
X-Received: by 2002:a05:690c:a203:20b0:8ab:4c8f:2844 with SMTP id
 00721157ae682-8b133d0ebfcmr23170057b3.39.1792662126711; Thu, 22 Oct 2026
 02:42:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <c07a80c76774c3dcdafcda659fc098278b1bdc96.1792504358.git.michal.simek@amd.com>
In-Reply-To: <c07a80c76774c3dcdafcda659fc098278b1bdc96.1792504358.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 22 Oct 2026 12:41:30 +0300
X-Gm-Features: AclHuK-Y2ugTjZMpPOgj17seksfmG98IdncOp4GQKrfLwoVDjOMw-axYn-CAk-w
Message-ID: <CAC_iWjJm5M=2_mBAywcXHgJ4-kez6T48bGArHo7XwFyiVNVgZg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: set dfu_alt_info before FWU alt num lookup
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks Michal,


On Tue, 20 Oct 2026 at 16:52, Michal Simek <michal.simek@amd.com> wrote:
>
> From: Padmarao Begari <padmarao.begari@amd.com>
>
> efi_firmware_raw_set_image() derives dfu_alt_num from image_index by
> calling fwu_get_dfu_alt_num() when CONFIG_FWU_MULTI_BANK_UPDATE is
> enabled. fwu_get_dfu_alt_num() calls fwu_plat_get_alt_num(), whose MTD
> and GPT backends call dfu_init_env_entities() to parse the
> "dfu_alt_info" env variable.
>
> "dfu_alt_info" is set from update_info.dfu_string further down, just
> before dfu_write_by_alt(). Boards that do not already have
> "dfu_alt_info" in the env hit fwu_get_dfu_alt_num() while it is still
> unset:
>
>   "dfu_alt_info" env variable not defined!
>   Firmware update failed: <NULL>
>   All capsules were not updated. Not updating FWU metadata
>
> Move the "dfu_alt_info" save and set above the dfu_alt_num derivation.
> Make the fwu_get_dfu_alt_num() error path goto restore_dfu instead of
> returning, so the old value is written back and orig_dfu_env is freed.
>
> Fixes: 546152624f46 ("efi_firmware: set EFI capsule dfu_alt_info env explicitly")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

I've qued up the CI and I don't expect it to fail.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>  lib/efi_loader/efi_firmware.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 84de95f5c230..346b00c1663a 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -765,6 +765,24 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>         if (status != EFI_SUCCESS)
>                 return EFI_EXIT(status);
>
> +       /*
> +        * "dfu_alt_info" must be set before fwu_get_dfu_alt_num(), which
> +        * parses it through dfu_init_env_entities() to locate the image.
> +        */
> +       orig_dfu_env = env_get("dfu_alt_info");
> +       if (orig_dfu_env) {
> +               orig_dfu_env = strdup(orig_dfu_env);
> +               if (!orig_dfu_env) {
> +                       log_err("strdup() failed!\n");
> +                       return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> +               }
> +       }
> +       if (env_set("dfu_alt_info", update_info.dfu_string)) {
> +               log_err("Unable to set env variable \"dfu_alt_info\"!\n");
> +               free(orig_dfu_env);
> +               return EFI_EXIT(EFI_DEVICE_ERROR);
> +       }
> +
>         /*
>          * dfu_alt_num is assigned from 0 while image_index starts from 1.
>          * dfu_alt_num is calculated by (image_index - 1) when multi bank update
> @@ -779,27 +797,14 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>                 ret = fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
>                 if (ret) {
>                         log_debug("Unable to get FWU image_index\n");
> -                       return EFI_EXIT(EFI_DEVICE_ERROR);
> +                       goto restore_dfu;
>                 }
>         }
>
> -       orig_dfu_env = env_get("dfu_alt_info");
> -       if (orig_dfu_env) {
> -               orig_dfu_env = strdup(orig_dfu_env);
> -               if (!orig_dfu_env) {
> -                       log_err("strdup() failed!\n");
> -                       return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> -               }
> -       }
> -       if (env_set("dfu_alt_info", update_info.dfu_string)) {
> -               log_err("Unable to set env variable \"dfu_alt_info\"!\n");
> -               free(orig_dfu_env);
> -               return EFI_EXIT(EFI_DEVICE_ERROR);
> -       }
> -
>         ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
>                                NULL, NULL);
>
> +restore_dfu:
>         if (env_set("dfu_alt_info", orig_dfu_env))
>                 log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
>
> ---
>
> --
> 2.43.0
>
