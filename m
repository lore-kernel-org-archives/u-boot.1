Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D25D606A31D
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 18:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H3qhKJmg;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=mIVahbce
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9C9A407EE;
	Tue, 27 Oct 2026 18:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8aDRahrCIWq5; Tue, 27 Oct 2026 18:00:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A75E340688
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793124042;
	b=fR0bTz7Kn7kQLw+J6iyFxwteBb5zXBYlEwS6+NzpEuEHqPZCsPN/mzJ1w3cfI2mUNp2U
	 un9dU2dGkgU3sVgH6rmKQrV4wcZxUmRlyzHXNETBAD6cFq5FWLeOCp0nFWlHEdG20Po7O
	 qI97VnJ7vXmSsl6HNqNw66vTCQgfvRzBqNVdQO9J2Os8t0nlIQZPxDpUQi1y4TNIkCFF+
	 zLglQ/xw1cFlOveTboDYld6QCopY8UL1SZTsaO4mjdiGQrfXlFLR7QyXpHM3O5BHp6WZZ
	 E/sl4sLsleLGHxjJeqnWLJJgEVZVXANJWxnTX8sUnWn9Mos4uza/DUDNAgd0HBXuC1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793124042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S04/lrT5wfoovkH5ZmNCZ+h+EPUgYZ7bgqplhG6WUl8=;
	b=hyQ1cmUVn9cFQoVqEVc6gFhAIKmL50ZKdlDw/lkG1MVP/OmrdkC4YeOd6KfEfrAlFP+q
	 Hf6kxOT7FiX9gCVtt0EDl28NccbrXIB+wO6vlMOflwndyBMc1ztbc3pSr1If1Jgga6uV5
	 dS1FSWM/c4/lmjbJVFpOLmRLJH7x2g99RlDuNfzS4p7k/CAcJL9PMtrsk3Ww3Uw8HeRrI
	 zJ/3w4IrnC3W+LS9Eod6ytm9cTugpef+nXMSo/HR7xGjI9zowS+XD9kCGZb7wdtGSQuUO
	 Lyxo7Bw7Ih2GWSP7VrPt+C8FSWJCJS3SWJDStlcRUKtplkgzIC3SDL9JSvl7Ft5zybw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=mIVahbce;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793124042;
	bh=S04/lrT5wfoovkH5ZmNCZ+h+EPUgYZ7bgqplhG6WUl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H3qhKJmgV3s7sAfNcvgWpRTBB20Ley27WtBLQqDENr9WRB5woc+NswB3Kzh7YPTq4
	 8NL0MI1tbjCnXJWcLgOsdHWcnwkKzlAoTxSmf2hf/+u965Hb870/FEC6Oat7cOf7J+
	 AmlN0dypuel1LGPeii3UJZmaydwsc1OxYFV/j/XNAxHeapRbMzcV7Dlcz0CfLjfTA/
	 a9fG/2dg/mKK7UpSppavoG2hdbNTmOxiNB/Hca05kNhv4sneYxWVUfqhLa4T8bYtbk
	 FybUiMbqF6NrQnftniBhCIkB/IcK0RgirwQTDAf5R0wwvEYBt8E7qufIBBlhUuV/ND
	 XtjJhLNn97pdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A75E340688;
	Tue, 27 Oct 2026 18:00:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 873AF235
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:00:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D0EB40688
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:00:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WgDHBDwwd_YI for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 18:00:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 918624066C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:38e0::42aa"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793124040;
 b=mbvELqzCVZFnyXBV4/yTjn6gn62rIancjOz1mJSKw9afIdEuxcFC2O8OLvduaW1BOPCb
 GVOWdGanS4GXScly2K/D2mClKvK4GuOpQVtuOWbLmbn+OByL0bLZfX8haA7sM6cFfKf4I
 1a15Ho6Q8+eRgSlJSOWZbVKF7aO7YcYB1I56TXVHu6fkVyXqUulUetnAEY1xH09HOx3Fm
 i+HkMWo0y/DrnYhuUU7eBjazbKFqSsN9MPvAuKamLBKnKnJX0IAx0uzTKNPdmwDDrbB0e
 mwb3RtofgFUXOIg+wDH1puBC7Yu6hYoltnWda6UM45Erp69uAIILfgPrwE/rlMI3TCQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793124040;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=S04/lrT5wfoovkH5ZmNCZ+h+EPUgYZ7bgqplhG6WUl8=;
 b=GDgkOKQ95i3SFEGJu+IX80pOLDIX/yXd2lv0suMTcJTRknVk1NC1YVLWQeHUqz4gpG9Z
 O/Vmq4WIa+XWQIs583EoE7hp3ooZmW7vEkXZ0yQncH4KRIFstSVmgOdMk0/oI41c/T8we
 7QnlaJO/9oDoxfak1yTx592lkgel7hOYHdnkhdJhZZ8JqyPqFz/AA9qd9a97+68ennLD1
 TAT97n1WkEHoNADYJNG/XfWJ5J4uIP1xkrgj7HA5atDopEksC3Y0BbTLw8MZ1gjRekTLV
 xv/LkSav9dl6CY6mfM+1QSXzICDoZGMr+ZtvQ1GjlOGGfuA30luUILzW6BYsyPlpRVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=mIVahbce; 
 arc=none smtp.remote-ip="2001:1600:19:38e0::42aa"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:38e0::42aa; helo=smtp-42aa.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=mIVahbce
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [IPv6:2001:1600:19:38e0::42aa])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 918624066C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 18:00:38 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jDdZX3fhlz1wH2;
 Tue, 27 Oct 2026 19:00:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793124036;
 bh=S04/lrT5wfoovkH5ZmNCZ+h+EPUgYZ7bgqplhG6WUl8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mIVahbceEmkj7Q4FDfUjKfnTzP4CssWUiPWlRa7K6gxXH3AbsJ6hB3mstr93oaRgC
 SKM9Iu2IqaypsPqLMHomDwl8/P6N36jcnZOuenHa05Qlxj92Duq2UmZBev7mtH/R16
 ynLYyRi+RYUNeigeO6Wt0+yEMdvKCMiuIk2CYX7smpLd/8cMLCzw42w+AuW2mKMQ9V
 MieK02eqZ++I5wOtreZjmEai2rxLk8CyosvkYVN8W89nN92GoNXOLb8oxywZ6HjYRK
 E9TziqlADTrToaMB1zuiHwyYwiwa1U57EypkpOnMxtDv7wXZtQ4mmriIwJKCuQQ512
 bLjuqS0D1db0Q==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jDdZW3q1sz24Y; Tue, 27 Oct 2026 19:00:35 +0100 (CET)
Message-ID: <6f3b7c32-05be-4f59-99ab-37978fac5bf9@0leil.net>
Date: Tue, 27 Oct 2026 19:00:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: Replace master with main as primary branch name
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
References: <20261018-master-main-v1-0-e07455d232bd@gmail.com>
 <20261018-master-main-v1-1-e07455d232bd@gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261018-master-main-v1-1-e07455d232bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Massimo,

On 10/18/26 5:59 PM, Massimo Pegorer wrote:
> The primary branch name is main, not master anymore. Update references
> still naming it master in the documentation, replacing master with main.
> 
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
>   doc/CONTRIBUTE.rst              |  6 +++---
>   doc/develop/sending_patches.rst | 12 ++++++------
>   tools/buildman/buildman.rst     |  8 ++++----
>   3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> index e0394515702..b012648e3f2 100644
> --- a/doc/CONTRIBUTE.rst
> +++ b/doc/CONTRIBUTE.rst
> @@ -73,11 +73,11 @@ considered as reasonable amount of time.
>   Development Branches
>   --------------------
>   
> -The U-Boot developers use two main branches for developing the code. The master
> +The U-Boot developers use two primary branches for developing the code. The main
>   branch is used for the current development cycle, while there is also a next
>   branch intended to land changes for the next release early to enable wider
> -testing of larger code changes. The next branch is merged to master shortly
> -after the tagging of a new major release.
> +testing of larger code changes. The next branch is merged to main shortly after
> +the tagging of a new major release.
>   

I think this paragraph would benefit from highlighting the main and next 
word with double tick quotes like we do later in this diff in the next 
file. Can be done in a follow-up patch though.

>   Similar to Linux there is a three week merge window post release after which a
>   release candidate is tagged. There's typically a new release candidate every
> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
> index b4f82eb18e1..8b8a70da4bb 100644
> --- a/doc/develop/sending_patches.rst
> +++ b/doc/develop/sending_patches.rst
> @@ -36,7 +36,7 @@ configuration file and ``scripts/get_maintainer.pl``.
>   .. code-block:: bash
>   
>      b4 prep -n mmc-fixes
> -   git rebase -i origin/master
> +   git rebase -i origin/main
>      b4 prep --edit-cover
>      b4 prep --auto-to-cc
>   
> @@ -65,7 +65,7 @@ fold them into your commits before resending the updated series.
>   .. code-block:: bash
>   
>      b4 trailers -u
> -   git rebase -i origin/master
> +   git rebase -i origin/main
>      b4 send
>   
>   Using patman
> @@ -132,11 +132,11 @@ General Patch Submission Rules
>   * Send your patches as plain text messages: no HTML, no MIME, no links, no
>     compression, no attachments. Just plain text. The best way to generate
>     patches is by using the ``git format-patch`` command. For a patch that is
> -  fixing a bug or regression of some sort, please use the ``master`` branch of
> +  fixing a bug or regression of some sort, please use the ``main`` branch of
>     the mainline U-Boot git repository located at
>     https://git.u-boot-project.org/u-boot/u-boot.git as reference. For new features, if
>     the ``next`` branch has been opened (which happens with the release of
> -  ``-rc2``) that branch should be used, otherwise ``master`` is acceptable.
> +  ``-rc2``) that branch should be used, otherwise ``main`` is acceptable.
>   
>   * Make sure that your mailer does not mangle the patch by automatic changes
>     like wrapping of longer lines etc.
> @@ -452,8 +452,8 @@ today. Not all states are used by all custodians.
>     it will be accepted for mainline.
>   
>   * Awaiting Upstream: A custodian may have applied this to the ``next`` branch
> -  and has not merged yet to master, or has queued the patch up to be submitted
> -  to be merged, but has not yet.
> +  and has not merged yet to ``main`` one, or has queued the patch up to be

Spurious "one" here?

Looks good to me otherwise.

Cheers,
Quentin
