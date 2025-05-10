Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF32C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EFD182AE2;
	Sat, 10 May 2025 13:07:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XQfJQiNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B969D8283E; Sat, 10 May 2025 13:06:43 +0200 (CEST)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A3982AF4
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-ad221e3e5a2so215655366b.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875196; x=1747479996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sDCuvDVwMVxkLyhS9pGArwjvqmJBq7Rv1sn38F/Cc8=;
 b=XQfJQiNYgW9zI0NLzOkfL/muKy9Mwq1S/2NXde3hM05vtA5MieNs4gsSdTiQtRGTot
 4CTJiOCf1ha8Yvc3uztKN19ZcNl9dhiIalnM0DWJSH9aBl/s8hPrO5aUOmC8d7ytpe7O
 KTqBcQ33i8ZKyPSMG6FilUfQilkF0P9xlf28E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875196; x=1747479996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3sDCuvDVwMVxkLyhS9pGArwjvqmJBq7Rv1sn38F/Cc8=;
 b=gEP8zfdB9p2OBdWTMQ6LjTLb0XP0KDopa6olloARCBhFvUicXq6nzYVDaRs6E7YynC
 QrJqdqmLSnF6h3Z3mTVGtCReojxHku3Khle3ghbOUIVFlxebkpnHthQi4hrNmAfT/cp/
 GM8Hl/KdzP3QKL9pTlfefjCU5USdHhVI7VGCitJsRcigCYNltHuVLwGWlUVqgTz/gpRA
 MyG8OLJbkKJvK3ZbeC2DIaXLxpbAGEf2GWKXxehFJipzrMCeP1Eorm/9jpr9k0GVthNq
 4nvCKqmtFMIxqCM5TIdCJiLbf0CM0qHTG7xcCBcU+qgZRQVpPJKuA7uZyYvAEXQRtzGA
 vIGw==
X-Gm-Message-State: AOJu0YyqSWnWESyB+tfP+CttPJH36e8SCJkTKCiulNBJ+RSJtqaECwrg
 vy3b89KuZW0jaSqDk3JJJKBvRansayMRP4/x/9UbIA6zEf2htiOJI7V0GJeuatgeI8genHkqnn3
 6QsUDyARBfP2I
X-Gm-Gg: ASbGncvnwNrgCE7tkBVLELbo9quCU21vLz9jwzQcykVL1qJok/6KlraqD8uBgSJbnIo
 4wfdS6WXjjbJ4wA78jOkCEVZhziCpNcvx+ptxbnF/VoLSX/ot28inq+MKkRHoYz69HA2+QX6Ch2
 yAUAi98UJcfJJTRrpzWSx8TmvvU5XdjMHqAQtICiDk5c7mhqPOEra/ym0yE2VFRNwZ7V2kWuG6D
 78Xr1BOB1lcFvnT3Z5U6Oi7PBUSbShSj3EcMkyqtgEZPRcRFj2WYwL7C7yFNgQkKuC/nxfVXB8d
 jroBSOevRZ7UP3LkGHa/oJMXe/WArSX5I0GwcsCTe0sqdqw=
X-Google-Smtp-Source: AGHT+IFZMVnus8ob0ER2dwZK1yY4PGbO38eRCcAR8SfFl961tGkK1SDG0d8yrq4qwUfVJu8AnIJDKw==
X-Received: by 2002:a17:907:6d28:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-ad218f41a8amr625713766b.13.1746875193298; 
 Sat, 10 May 2025 04:06:33 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Douglas Anderson <dianders@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/25] patman: Add basic documentation for new features
Date: Sat, 10 May 2025 13:05:18 +0200
Message-ID: <20250510110535.1453745-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 10 May 2025 13:07:09 +0200
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

Describe the new subcommands and how they should be used in a normal
workflow.

Note that the naming of branches is very rigid, or 'opinionated' in
marketing terms. Patman can track a single branch for each version of a
series and they must all be named the same, except for the
version-number suffix. Version 1 series have no suffix.

This description is fairly bare-bones but should be enough for some
initial testing and comments.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/pics/patman.jpg | Bin 0 -> 97131 bytes
 tools/patman/patman.rst     | 283 +++++++++++++++++++++++++++++++++++-
 2 files changed, 280 insertions(+), 3 deletions(-)
 create mode 100644 doc/develop/pics/patman.jpg

diff --git a/doc/develop/pics/patman.jpg b/doc/develop/pics/patman.jpg
new file mode 100644
index 0000000000000000000000000000000000000000..2dcf598e08897780ae8d660a63529a667741725f
GIT binary patch
literal 97131
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
K@t*noo&O)`nR&+m

literal 0
HcmV?d00001

diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
index 63b95a6b161..549e203c254 100644
--- a/tools/patman/patman.rst
+++ b/tools/patman/patman.rst
@@ -16,12 +16,13 @@ This tool is a Python script which:
 - Inserts a cover letter with change lists
 - Runs the patches through checkpatch.pl and its own checks
 - Optionally emails them out to selected people
+- Links the series automatically to Patchwork once sent
 
 It also has some Patchwork features:
 
-- shows review tags from Patchwork so you can update your local patches
-- pulls these down into a new branch on request
-- lists comments received on a series
+- Manage local series and their status on patchwork
+- Show review tags from Patchwork and allows them to be gathered into commits
+- List comments received on a series
 
 It is intended to automate patch creation and make it a less
 error-prone process. It is useful for U-Boot and Linux work so far,
@@ -659,6 +660,282 @@ so to send them:
 and it will create and send the version 2 series.
 
 
+Series Management
+-----------------
+
+Sometimes you might have several series in flight at the same time. Each of
+these receives comments and you want to create a new version of each series with
+those comments addressed.
+
+Patman provides a few subcommands which are helpful for managing series.
+
+Series and branches
+~~~~~~~~~~~~~~~~~~~
+
+'patman series' works with the concept of a series. It maintains a local
+database (.patman.db in your top-level git tree) and uses that to keep track of
+series and patches.
+
+Each series goes through muliple versions. Patman requires that the first
+version of your series is in a branch without a numeric suffix. Branch names
+like 'serial' and 'video' are OK, but 'part3' is not. This is because Patman
+uses the number at the end of the branch name to indicate the version.
+
+If your series name is 'video', then you can have a 'video' branch for version
+1 of the series, 'video2' for version 2 and 'video3' for version 3. All three
+branches are for the same series. Patman keeps track of these different
+versions. It handles the branch naming automatically, but you need to be aware
+of what it is doing.
+
+You will have an easier time if the branch names you use with 'patman series'
+are short, no more than 15 characters. This is the amount of columnar space in
+listings. You can add a longer description as the series description. If you
+are used to having very descriptive branch names, remember that patman lets you
+add metadata into commit which is automatically removed before sending.
+
+This documentation uses the term 'series' to mean all the versions of a series
+and 'series/version' to mean a particular version of a series.
+
+Updating commits
+~~~~~~~~~~~~~~~~
+
+Since Patman provides quite a bit of automation, it updates your commits in
+some cases, effectively doing a rebase of a branch in order to change the tags
+in the commits. It never makes code changes.
+
+In extremis you can use 'git reflog' to revert something that Patman did.
+
+
+Series subcommands
+~~~~~~~~~~~~~~~~~~
+
+Note that 'patman series ...' can be abbreviated as 'patman s' or 'patman ser'.
+
+Here is a short overview of the available subcommands:
+
+    add
+        Add a new series. Use this on an existing branch to tell Patman about it.
+
+    archive (ar)
+        Archive a series when you have finished upstreaming it. Archived series
+        are not shown by most commands. This creates a dated tag for each
+        version of the series, pointing to the series branch, then deletes the
+        branches. It puts the tag names in the database so that it can
+        'unarchive' to restore things how they were.
+
+    unarchive (unar)
+        Unarchive a series when you decide you need to do something more with
+        it. The branches are restored and tags deleted.
+
+    autolink (au)
+        Search patchwork for the series link for your series, so Patman can
+        track the status
+
+    autolink-all
+        Same but for all series
+
+    inc
+        Increase the series number, effectively creating a new branch with the
+        next highest version number. The new branch is created based on the
+        existing branch. So if you use 'patman series inc' on branch 'video2'
+        it will create branch 'video3' and add v3 into its database
+
+    dec
+        Decrease the series number, thus deleting the current branch and
+        removing that version from the data. If you use this comment on branch
+        'video3' Patman will delete version 3 and branch 'video3'.
+
+    get-link
+        Shows the Patchwork link for a series/version
+
+    ls
+        Lists the series in the database
+
+    mark
+        Mark a series with 'Change-Id' tags so that Patman can track patches
+        even when the subject changes. Unmarked patches just use the subject to
+        decided which is which.
+
+    unmark
+        Remove 'Change-Id' tags from a series.
+
+    open (o)
+        Open a series in Patchwork using your web browser
+
+    patches
+        Show the patches in a particular series/version
+
+    progress (p)
+        Show upstream progress for your series, or for all series
+
+    rm
+        Remove a series entirely, including all versions
+
+    rm-version (rmv)
+        Remove a particular version of a series. This is similar to 'dec'
+        except that any version can be removed, not just the latest one.
+
+    scan
+        Scan the local branch and update the database with the set of patches
+        in that branch. This throws away the old patches.
+
+    send
+        Send a series out as patches. This is similar to 'patman send' except
+        that it can send any series, not just the current branch. It also
+        waits a little for patchwork to see the cover letter, so it can find
+        out the patchwork link for the series.
+
+    set-link
+        Sets the Patchwork link for a series-version manually.
+
+    status (st)
+        Run 'patman status' on a series. This is similar to 'patman status'
+        except that it can get status on any series, not just the current
+        branch
+
+    summary
+        Shows a quick summary of series with their status and description.
+
+    sync
+        Sync the status of a series with Pathwork, so that
+        'patman series progress' can show the right information.
+
+    sync-all
+        Sync the status of all series.
+
+
+Patman series workflow
+~~~~~~~~~~~~~~~~~~~~~~
+
+Here is a run-through of how to incorporate 'patman series' into your workflow.
+
+Firstly, set up your project::
+
+    patman patchwork set-project U-Boot
+
+This just tells Patman to look on the Patchwork server for a project of that
+name. Internally Patman stores the ID and URL 'link-name' for the project, so it
+can access it.
+
+If you need to use a different patchwork server, use the `--patchwork-url`
+option or put the URL in your Patman-settings file.
+
+Now create a branch. For our example we are going to send out a series related
+to video so the branch will be called 'video'. The upstream remove is called
+'us'::
+
+    git checkout -b video us/master
+
+We now have a branch and so we can do some commits::
+
+    <edit files>
+    git add ...
+    <edit files>
+    git add -u
+    git commit ...
+    git commit ...
+
+We now have a few commits in our 'video' branch. Let's tell patman about it::
+
+    patman series add
+
+Like most commands, if no series is given (`patman series -s video add`) then
+the current branch is assumed. Since the branch is called 'video' patman knows
+that it is version one of the video series.
+
+You'll likely get a warning that there is no cover letter. Let's add some tags
+to the top commit::
+
+    Series-to: u-boot
+    Series-cc: ...
+    Cover-letter:
+    video: Improve syncing performance with cyclic
+
+Trying again::
+
+    patman series add
+
+You'll likely get a warning that the commits are unmarked. You can either let
+patman add Change-Id values itself with the `-m` flag, or tell it not to worry
+about it with `-M`. You must choose one or the other. Let's leave the commits
+unmarked::
+
+    patman series add -M
+
+Congratulations, you've now got a patman database!
+
+Now let's send out the series. We will add tags to the top commit.
+
+To send it::
+
+    patman series send
+
+You should send 'git send-email' start up and you can confirm the sending of
+each email.
+
+After that, patman waits a bit to see if it can find your new series appearing
+on Patchwork. With a bit of luck this will only take 20 seconds or so. Then your
+series is linked.
+
+To gather tags (Reviewed-by ...) for your series from patchwork::
+
+    patman series gather
+
+Now you can check your progress::
+
+    patman series progress
+
+Later on you get some comments, or perhaps you just decide to make a change on
+your own. You have several options.
+
+The first option is that you can just create a new branch::
+
+    git checkout -b video2 video
+
+then you can add this 'v2' series to Patman with::
+
+    patman series add
+
+The second option is to get patman to create the new 'video2' branch in one
+step::
+
+    patman inc
+
+The third option is to collect some tags using the 'patman status' command and
+put them in a new branch::
+
+    patman status -d video2
+
+One day the fourth option will be to ask patman to collect tags as part of the
+'patman inc' command.
+
+Again, you do your edits, perhaps adding/removing patches, rebasing on -master
+and so on. Then, send your v2::
+
+    patman series send
+
+Let's say the patches are accepted. You can use::
+
+    patch series gather
+    patch series progress
+
+to check, or::
+
+    patman series status -cC
+
+to see comments. You can now archive the series::
+
+    patman series archive
+
+At this point you have the basics. Some of the subcommands useful options, so
+be sure to check out the help.
+
+Here is a sample 'progress' view:
+
+.. image:: pics/patman.jpg
+  :width: 800
+  :alt: Patman showing the progress view
+
 General points
 --------------
 
-- 
2.43.0

