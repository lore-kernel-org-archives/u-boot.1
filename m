Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1684DC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 10:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68D3087C10;
	Tue,  6 Feb 2024 11:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="ulsBi4yx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EBD387C5B; Tue,  6 Feb 2024 11:43:42 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D2B87B8A
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 11:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707216219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XowZQlPkmDSZvfwNZj4W06c4f2/v8djEdmqODxFjXJo=;
 b=ulsBi4yx0e12ffXYLI07RdnqL22FTh/eryonZDzlpmZ02DkaRl4OnisCV7kCTcXAeRhn9j
 PLdXgEyY4MTM+TD144oNo0m/ZtawCoZBSDvwbXCMdGBNT4qgLSXoFyHmOU7ly8CdfEqpE9
 YOtQ/IADAlvvnqhEn/nuKvDKC81PUnNJQN2tq/DVWXIuFD6TDuB7EEmiXZmhuBfZGhHsWK
 5SBjjN+M2VnHxdPqTJDiGdZoafMw7ftjFPPma0BfS7a6ZhLC7Mmdg16Gsa1ARjBXAkAGYL
 Co0z5KISQhG+bjFhoMRzo7N1bd0KxRNMSs1LZbLXGA8yGIO+XMCIFBFnlLOECQ==
Date: Tue, 06 Feb 2024 11:43:39 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com,
 martin@geanix.com
Subject: Re: [PATCH] scripts: dtc-version: Don't show error messages
In-Reply-To: <799f8e94-b0b1-46ad-90e2-c98a67de91cc@theobroma-systems.com>
References: <aebd96be57ec59ace348287094ab919ce82711c9.1707191569.git.dsimic@manjaro.org>
 <2493a32f-8795-4c71-b719-039db0f0ad24@theobroma-systems.com>
 <ba0ff826dbaff3b23a8a9fa27e5d663d@manjaro.org>
 <799f8e94-b0b1-46ad-90e2-c98a67de91cc@theobroma-systems.com>
Message-ID: <79307c16a84692fcc68799ada7a10567@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2024-02-06 11:41, Quentin Schulz wrote:
> On 2/6/24 11:37, Dragan Simic wrote:
>> On 2024-02-06 11:25, Quentin Schulz wrote:
>>> On 2/6/24 04:56, Dragan Simic wrote:
>>>> Prevent the error messages produced by which(1), such as the one
>>>> quoted
>>>> below, from being visible in the build outputs.
>>>> 
>>>>      which: no dtc in (./scripts/dtc)
>>>> 
>>>> This makes the build outputs look a tiny bit cleaner.
>>>> 
>>>> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>>>> ---
>>>>   scripts/dtc-version.sh | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>> 
>>>> diff --git a/scripts/dtc-version.sh b/scripts/dtc-version.sh
>>>> index 53ff868bcdce..6d3d7b68fdfa 100755
>>>> --- a/scripts/dtc-version.sh
>>>> +++ b/scripts/dtc-version.sh
>>>> @@ -15,7 +15,7 @@ if [ ${#dtc} -eq 0 ]; then
>>>>          exit 1
>>>>   fi
>>>> 
>>>> -if ! which $dtc >/dev/null ; then
>>>> +if ! which $dtc >/dev/null 2>/dev/null ; then
>>> 
>>> What about
>>> 
>>> which $dtc > /dev/null 2>&1
>>> 
>>> instead?
>> 
>> That's exactly what I intended to use, but IIRC some shells
>> or some older versions of some shells may not recognize that,
>> so I went with a more verbose, but slightly safer option.
>> 
> 
> $ git -c core.pager='' grep "2>&1" scripts
> scripts/Kbuild.include:		if (which $(strip $(c))$(CC)) > /dev/null 2>&1 
> ; then \
> scripts/Kbuild.include:	if ($(1)) >/dev/null 2>&1;	\
> scripts/Kbuild.include:cc-name = $(shell $(CC) -v 2>&1 | grep -q
> "clang version" && echo clang || echo gcc)
> scripts/Kconfig.include:if-success = $(shell,{ $(1); } >/dev/null 2>&1
> && echo "$(2)" || echo "$(3)")
> scripts/checkpatch.pl:		$maintained_status{$filename} = `perl
> $root/scripts/get_maintainer.pl --status --nom --nol --nogit
> --nogit-fallback -f $filename 2>&1`;
> scripts/checkpatch.pl:	my $output = `${git_command} log --no-color
> --format='%H %s' -1 $commit 2>&1`;
> scripts/coccicheck:echo $SPFLAGS | grep -Ee "--profile|--show-trying"
> 2>&1 > /dev/null
> scripts/decodecode:	${CROSS_COMPILE}as $AFLAGS -o $1.o $1.s > /dev/null 
> 2>&1
> scripts/decodecode:		grep -v "/tmp\|Disassembly\|\.text\|^$" > $1.dis 
> 2>&1
> scripts/gcc-stack-usage.sh:cat <<END | $@ -Werror -fstack-usage -x c -
> -c -o $TMP >/dev/null 2>&1 \
> scripts/get_maintainer.pl:		my $output = `git ls-remote --exit-code -h
> "$url" $branch > /dev/null 2>&1`;
> scripts/get_maintainer.pl:    $cmd .= " 2>&1";
> scripts/kernel-doc:	open IN, "$cmd --version 2>&1 |";
> 
> 
> So we're probably fine?

Obviously. :)  I'll send the v2.
